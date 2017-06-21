class AddCpfReceiverToNotification < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :cpf_receiver, :string
  end
end
