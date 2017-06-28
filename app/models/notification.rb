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

  enumerize :status, in: %i[success failure cancel]

  def individual_notification(cpfs)
    cpfs.flatten.each do |individual|
      user = User.find_by(cpf: individual)
      IndividualNotification.create(user_id: user.id, notification_id: id)
      NotifierJob.perform_later(individual, user, user.notifications_actives)
    end
  end

  def send_for_channel; end
end
