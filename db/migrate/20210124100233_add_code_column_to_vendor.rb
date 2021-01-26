class AddCodeColumnToVendor < ActiveRecord::Migration[6.0]
  def change
  	add_column :vendors, :code, :string
  	add_column :vendor_products, :handle, :string
  end
end
