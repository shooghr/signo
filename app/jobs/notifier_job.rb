class NotifierJob < ApplicationJob
  queue_as :default

  def perform(cpf, nome, notifications)
    ActionCable.server.broadcast "notification_channel_#{cpf}",
                                 notifications: { receiver: nome, message: notifications }
  end
end
