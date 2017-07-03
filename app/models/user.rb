class User < ApplicationRecord
  has_many :individual_notifications, dependent: :destroy
  has_many :notifications, through: :individual_notifications
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def notifications_actives
    notifications.last_not_read.map { |n| n.map_attributes(id) }
  end

  def abstract_attributes
    attributes.slice('id', 'username', 'email')
  end
end
