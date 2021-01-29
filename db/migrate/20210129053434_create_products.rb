class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.bigint :shopify_product_id
      t.string :shopify_handle
      t.float :sme_commission
      t.json :shopify_product_data

      t.timestamps
    end
  end
end
