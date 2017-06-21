class CreateIndividualNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :individual_notifications do |t|
      t.notification :references
      t.user :references
      t.string :status

      t.timestamps
    end
  end
end
