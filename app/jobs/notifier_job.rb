class NotifierJob < ApplicationJob
  queue_as :default

  def perform(cpf)
    user = User.find_by(cpf: cpf)

    ActionCable.server
               .broadcast "notification_channel_#{cpf}",
                          notifications:
                          {
                            receiver: user.abstract_attributes,
                            all_message: { link: "#{url}/users/#{user.id}/notifications" },
                            mark_all_read: { link: "#{url}/users/#{user.id}/notifications/mark_all_read" },
                            message: user.notifications_actives
                          }
  end

  def url
    YAML.safe_load(File.read("#{Rails.root}/config/url.yml"))[Rails.env]['host']
  end
end
