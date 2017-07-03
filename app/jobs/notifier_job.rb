class NotifierJob < ApplicationJob
  queue_as :default

  def perform(cpf)
    user = User.select(:id, :cpf, :email, :username).find_by(cpf: cpf)

    ActionCable.server
               .broadcast "notification_channel_#{cpf}",
                          notifications:
                          { 
                            receiver: user,
                            all_message: { link: "http://localhost:3002/users/#{user.id}/notifications" },
                            mark_all_read: { link: nil },
                            message: user.notifications_actives
                          }
  end
end
