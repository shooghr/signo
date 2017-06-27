class User < ApplicationRecord
  has_many :individual_notifications, dependent: :destroy
  has_many :notifications, through: :individual_notifications
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def notifications_actives
    notifications.includes(:individual_notifications).where('individual_notifications.status is null').last(10)
  end
end
