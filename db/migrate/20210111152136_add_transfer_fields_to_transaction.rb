class AddTransferFieldsToTransaction < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :type_transfer, :integer
    add_column :transactions, :account_sender_id, :integer
    add_column :transactions, :account_recipient_id, :integer
  end
end
