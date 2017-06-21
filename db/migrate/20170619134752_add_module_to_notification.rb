class AddModuleToNotification < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :module, :string
  end
end
