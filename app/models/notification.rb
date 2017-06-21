class Notification < ApplicationRecord
  extend Enumerize

  CHANNEL = {
    1 => %i[system], 2 => %i[email], 3 => %i[susiebot],
    12 => %i[system email], 13 => %i[system susiebot], 23 => %i[email susiebot],
    123 => %i[system email susiebot]
  }.freeze

  enumerize :status, in: %i[success failure cancel]

  after_create_commit { NotifierJob.perform_later('35308899894', Notification.last(10)) }

  def send_for_channel; end
end
