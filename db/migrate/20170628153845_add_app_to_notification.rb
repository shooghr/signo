class AddAppToNotification < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :app, :string
  end
end
