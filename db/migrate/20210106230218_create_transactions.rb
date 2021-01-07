class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.integer :type_transaction
      t.float :value
      t.string :description
      t.float :tax
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
