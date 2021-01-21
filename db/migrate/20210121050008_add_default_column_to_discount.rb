class AddDefaultColumnToDiscount < ActiveRecord::Migration[6.0]
  def change
  	add_column :discounts, :default, :boolean, default: false
  end
end
