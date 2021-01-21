class AddColumnsToUser < ActiveRecord::Migration[6.0]
  def change
  	add_column :sme_users, :max_commission, :float
  	add_column :sme_users, :reference_code, :string
  	add_column :sme_users, :active, :boolean, default: false
  	add_column :sme_users, :name, :string
  end
end
