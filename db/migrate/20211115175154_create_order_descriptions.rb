class CreateOrderDescriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :order_descriptions do |t|
      t.integer :order_id
      t.integer :item_id
      t.integer :quantity

      t.timestamps
    end
  end
end
