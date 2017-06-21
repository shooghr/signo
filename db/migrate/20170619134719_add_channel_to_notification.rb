class AddChannelToNotification < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :channel, :integer
  end
end
