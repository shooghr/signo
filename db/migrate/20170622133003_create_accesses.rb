class CreateAccesses < ActiveRecord::Migration[5.0]
  def change
    create_table :accesses do |t|
      t.references :user, foreign_key: true
      t.integer :system
      t.integer :count

      t.timestamps
    end
  end
end
