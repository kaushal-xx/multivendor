class AddTaxColumnToProduct < ActiveRecord::Migration[6.0]
  def change
  	add_column :products, :application_commission_tax, :float
  	add_column :products, :sme_commission_tax, :float
  end
end
