class CreateVendorAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :vendor_addresses do |t|
      t.references :vendor, null: false, foreign_key: true
      t.string :lat
      t.string :lon
      t.text :address1
      t.text :address2
      t.string :city
      t.string :state
      t.string :country
      t.string :pincode
      t.text :google_address

      t.timestamps
    end
  end
end
