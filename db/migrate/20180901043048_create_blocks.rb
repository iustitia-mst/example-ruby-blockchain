class CreateBlocks < ActiveRecord::Migration[5.2]
  def change
    create_table :blocks do |t|
      t.integer :index
      t.string :previous_hash
      t.integer :generated_at
      t.text :hash_value
      t.text :data_value
      t.timestamps
    end
  end
end
