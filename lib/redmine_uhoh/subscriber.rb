module RedmineUhoh::Subscriber
  ActiveSupport::Notifications.subscribe "process_action.action_controller" do |name, start, finish, id, payload|
    if payload[:exception]
      name, message = *payload[:exception]
      backtrace = $!.present? ? $!.backtrace.join("\n") : ""
      if User.current.logged?
        login = User.current.login
        user_id = User.current.id
      else
        login = "anonymous"
        user_id = nil
      end

      failure = Failure.new
      attrs = { 'name': name,
                'message': message,
                'backtrace': backtrace,
                'path': payload[:path],
                'login': login,
                'user_id': user_id }
      failure.safe_attributes = attrs
      failure.save!
      # Failure.create!(:name => name, :message => message, :backtrace => backtrace, :login => login, :user_id => user_id)
    end
  end
end
