class NotificationChannel < ApplicationCable::Channel
  def subscribed
    if params['user'].nil?
      stop_all_streams
      stream_from 'notification_channel'
    else
      stop_all_streams
      stream_from "notification_channel_#{params['user']}"
      NotifierJob.perform_later(params['user'])
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def listen; end

  def speak; end
end
