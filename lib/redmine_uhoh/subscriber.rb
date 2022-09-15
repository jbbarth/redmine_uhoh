require_dependency 'failure' if Rails::VERSION::MAJOR < 6

def handle_exception_payload(payload)
  return unless payload[:exception]

  name, message = *payload[:exception]
  # rubocop: disable Style/SpecialGlobalVars
  backtrace = $!.present? ? $!.backtrace.join("\n") : ''
  # rubocop: enable Style/SpecialGlobalVars
  if User.current.logged?
    login = User.current.login
    user_id = User.current.id
  else
    login = 'anonymous'
    user_id = nil
  end

  failure = Failure.new
  # HACK: cut-off very long messages to avoid getting out of space for the column
  message = message.slice(0, 65_535) if message.length > 65_535
  attrs = { 'name' => name,
            :message => message,
            :backtrace => backtrace,
            :path => payload[:path],
            :login => login,
            :user_id => user_id,
            :context => payload.inspect }
  failure.safe_attributes = attrs
  saved = failure.save
  Rails.logger.error("Could not save failure #{failure} because of #{failure.errors.full_messages}") unless saved
end

ActiveSupport::Notifications.subscribe 'process_action.action_controller' do |_name, _start, _finish, _id, payload|
  handle_exception_payload(payload)
end

ActiveSupport::Notifications.subscribe 'z_app_engine.initialization' do |_name, _start, _finish, _id, payload|
  handle_exception_payload(payload)
end
