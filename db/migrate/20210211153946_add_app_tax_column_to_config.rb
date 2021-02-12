class AddAppTaxColumnToConfig < ActiveRecord::Migration[6.0]
  def change
  	add_column :configs, :app_commission_tax, :float, default: 0.0
  	add_column :configs, :sme_commission_tax, :float, default: 0.0
  end
end
