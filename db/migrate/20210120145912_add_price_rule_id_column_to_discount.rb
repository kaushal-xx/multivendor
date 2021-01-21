class AddPriceRuleIdColumnToDiscount < ActiveRecord::Migration[6.0]
  def change
  	add_column :discounts, :shopify_price_rule_id, :bigint
  	add_column :discounts, :shopify_price_rule_data, :json
  end
end
