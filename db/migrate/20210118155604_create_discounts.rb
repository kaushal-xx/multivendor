class CreateDiscounts < ActiveRecord::Migration[6.0]
  def change
    create_table :discounts do |t|
      t.bigint :shopify_discount_id
      t.json :shopify_discount_data
      t.references :sme_user, null: false, foreign_key: true
      t.string :shopify_discount_code
      t.boolean :active
      t.float :shopify_discount_presents

      t.timestamps
    end
  end
end
