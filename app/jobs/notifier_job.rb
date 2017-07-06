class NotifierJob < ApplicationJob
  queue_as :default

  def perform(cpf)
    user = User.find_by(cpf: cpf)
    messages = user.notifications_actives
    return if messages.empty?
    ActionCable.server.broadcast "notification_channel_#{cpf}",
                                 notifications:
                                  {
                                    all_message: { link: "#{url}/users/#{user.id}/notifications" },
                                    mark_all_read: { link: "#{url}/users/#{user.id}/notifications/mark_all_read" },
                                    message: messages
                                  }
  end

  def url
    YAML.safe_load(File.read("#{Rails.root}/config/url.yml"))[Rails.env]['host']
  end
end
