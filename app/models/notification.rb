require 'systens'

class Notification < ApplicationRecord
  extend Enumerize
  has_many :individual_notifications, dependent: :destroy
  has_many :users, through: :individual_notifications

  CHANNEL = {
    1 => %i[system], 2 => %i[email], 3 => %i[susiebot],
    12 => %i[system email], 13 => %i[system susiebot], 23 => %i[email susiebot],
    123 => %i[system email susiebot]
  }.freeze

  enumerize :status, in: %i[success failure cancel]

  def individual_notification(cpfs)
    cpfs.each do |individual|
      NotifierJob.perform_later(individual[:cpf], Notification.last(15))
    end
  end

  def send_for_channel; end
end
