class AddNonceColumnToBlock < ActiveRecord::Migration[5.2]
  def change
    add_column :blocks, :nonce, :integer
  end
end
