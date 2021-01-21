class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.bigint :shopify_order_id
      t.json :shopify_order_data
      t.references :sme_user, null: false, foreign_key: true
      t.float :shopify_order_amount
      t.float :sme_user_commission
      t.float :shopify_order_discount_amount

      t.timestamps
    end
  end
end
