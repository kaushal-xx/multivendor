class AddApplicationCommissionColumnToProduct < ActiveRecord::Migration[6.0]
  def change
  	add_column :products, :application_commission, :float, default: 0.0
  end
end
