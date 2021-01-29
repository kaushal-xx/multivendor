class CreateDraftOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :draft_orders do |t|
      t.bigint :shopify_order_id
      t.json :shopify_order_data
      t.references :sme_user, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
