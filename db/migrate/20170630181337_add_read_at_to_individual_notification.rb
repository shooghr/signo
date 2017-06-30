class AddReadAtToIndividualNotification < ActiveRecord::Migration[5.0]
  def change
    add_column :individual_notifications, :read_at, :datetime
  end
end
