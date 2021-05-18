class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name,             null: false
      t.text :desc,               null: false
      t.integer :price,           null: false
      t.integer :stock,           null: false
      t.references :user,         null: false,foreign_key: true
      t.integer :category_id,     null: false
      t.integer :status_id,       null: false
      t.integer :shippingfee_id, null: false
      t.integer :prefecture_id,   null: false
      t.integer :esd_id,          null: false
      t.timestamps
    end
  end
end