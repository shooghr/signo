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
    includes(:individual_notifications).where('individual_notifications.status is null').last(10)
  }

  enumerize :status, in: %i[success failure cancel]

  def individual_notification(cpfs)
    cpfs.flatten.each do |individual|
      IndividualNotification.create(user_id: user.id, notification_id: id)
      NotifierJob.perform_later(individual)
    end
  end

  def send_for_channel; end

  def link_redirect(user_id)
    "http//signo.defensoria.to.gov.br/users/#{user_id}/notification/#{id}/redirect"
  end

  def map_attributes(user_id)
    attributes.slice('id', 'content', 'title', 'created_at', 'app')
              .merge(link: link_redirect(user_id))
              .merge(sender: sender.abstract_attributes)
  end
end
