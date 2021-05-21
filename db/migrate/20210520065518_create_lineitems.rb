class CreateLineitems < ActiveRecord::Migration[6.0]
  def change
    create_table :lineitems do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.integer :quantity, default: 0
      t.timestamps
    end
  end
end
