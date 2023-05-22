class SendingEmailJob < ApplicationJob
  queue_as :default

  def perform(friend)
    # Do something later
    CrudNotificationMailer.create_notification(friend).deliver_now

  end
end
