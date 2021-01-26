class VendorOrder < ApplicationRecord
  belongs_to :vendor
  belongs_to :vendor_product
  belongs_to :vendor_variant
end
