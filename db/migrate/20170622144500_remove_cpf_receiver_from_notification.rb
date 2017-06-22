class RemoveCpfReceiverFromNotification < ActiveRecord::Migration[5.0]
  def change
    remove_column :notifications, :cpf_receiver, :string
  end
end
