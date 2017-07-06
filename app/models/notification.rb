require 'systens'

class Notification < ApplicationRecord
  extend Enumerize

  belongs_to :sender, foreign_key: 'sender', class_name: 'User'

  has_many :individual_notifications, dependent: :destroy
  has_many :users, through: :individual_notifications

  CHANNEL = {
    1 => %i[system], 2 => %i[email], 3 => %i[susiebot],
    12 => %i[system email], 13 => %i[system susiebot], 23 => %i[email susiebot],
    123 => %i[system email susiebot]
  }.freeze

  scope :last_not_read, -> {
    includes(:individual_notifications).where('individual_notifications.read_at is null').last(10)
  }

  enumerize :status, in: %i[success failure cancel]

  def individual_notification(cpfs)
    # binding.pry
    cpfs&.flatten&.each do |individual|
      user_id = User.find_by(cpf: individual).id
      IndividualNotification.create(user_id: user_id, notification_id: id)
      NotifierJob.perform_later(individual)
    end
  end

  def send_for_channel; end

  def link_action(user_id, action)
    "#{url}/users/#{user_id}/notifications/#{id}/#{action}"
  end

  def map_attributes(user_id)
    slice('id', 'content', 'title', 'created_at', 'app').merge(link: link_action(user_id, 'redirect'))
                                                        .merge(mark_as_read: link_action(user_id, 'mark_as_read'))
                                                        .merge(sender: sender.abstract_attributes)
  end

  def url
    YAML.safe_load(File.read("#{Rails.root}/config/url.yml"))[Rails.env]['host']
  end
end
