class RemoveRecipientFromNotification < ActiveRecord::Migration[5.0]
  def change
    remove_column :notifications, :recipient, :string
  end
end
