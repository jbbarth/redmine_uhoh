require_dependency 'failure'

ActiveSupport::Notifications.subscribe 'process_action.action_controller' do |name, _start, _finish, _id, payload|
  if payload[:exception]
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

    # TODO : Find a way to remove 'assign without protection' and use safe_attributes
    # or create!(attrs) directly, without mass_assignment error
    failure = Failure.new
    attrs = { 'name' => name,
              :message => message,
              :backtrace => backtrace,
              :path => payload[:path],
              :login => login,
              :user_id => user_id,
              :context => payload.inspect }
    failure.assign_attributes(attrs, without_protection: true)
    failure.save!
    # Failure.create!(:name => name, :message => message, :backtrace => backtrace, :login => login, :user_id => user_id)
  end
end
