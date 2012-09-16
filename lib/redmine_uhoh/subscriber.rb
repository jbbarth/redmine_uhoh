ActiveSupport::Notification.subscribe "process_action.action_controller" do |payload|
  if payload[:exception]
    name, message = *payload[:exception]
    Failure.create!(:name => name, :message => message)
  end
end
