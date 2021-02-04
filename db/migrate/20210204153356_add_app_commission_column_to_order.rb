class AddAppCommissionColumnToOrder < ActiveRecord::Migration[6.0]
  def change
  	add_column :orders, :app_commission, :float, default: 0.0
  	add_column :orders, :app_commission_tax, :float, default: 0.0
  	add_column :orders, :sme_user_commission_tax, :float, default: 0.0
  end
end
