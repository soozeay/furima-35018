class CreateCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :coupons do |t|
      t.integer :content_id, null: false
      t.references :user, null: false
      t.boolean :is_valid, default: true
      t.integer :limit
      t.timestamps
    end
  end
end
