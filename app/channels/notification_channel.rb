class NotificationChannel < ApplicationCable::Channel
  def subscribed
    if params['user'].nil?
      stop_all_streams
      stream_from 'notification_channel'
    else
      stop_all_streams
      user = User.find_by(cpf: params['user'])
      stream_from "notification_channel_#{params['user']}"
      NotifierJob.perform_later(params['user'], user.cpf, user.notifications_actives)
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def listen; end

  def speak; end
end
