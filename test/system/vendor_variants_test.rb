require "application_system_test_case"

class VendorVariantsTest < ApplicationSystemTestCase
  setup do
    @vendor_variant = vendor_variants(:one)
  end

  test "visiting the index" do
    visit vendor_variants_url
    assert_selector "h1", text: "Vendor Variants"
  end

  test "creating a Vendor variant" do
    visit vendor_variants_url
    click_on "New Vendor Variant"

    fill_in "Shopify product", with: @vendor_variant.shopify_product_id
    fill_in "Shopify variant data", with: @vendor_variant.shopify_variant_data
    fill_in "Shopify variant", with: @vendor_variant.shopify_variant_id
    fill_in "Shopify variant price", with: @vendor_variant.shopify_variant_price
    fill_in "Stock count", with: @vendor_variant.stock_count
    fill_in "Vendor", with: @vendor_variant.vendor_id
    fill_in "Vendor product", with: @vendor_variant.vendor_product_id
    click_on "Create Vendor variant"

    assert_text "Vendor variant was successfully created"
    click_on "Back"
  end

  test "updating a Vendor variant" do
    visit vendor_variants_url
    click_on "Edit", match: :first

    fill_in "Shopify product", with: @vendor_variant.shopify_product_id
    fill_in "Shopify variant data", with: @vendor_variant.shopify_variant_data
    fill_in "Shopify variant", with: @vendor_variant.shopify_variant_id
    fill_in "Shopify variant price", with: @vendor_variant.shopify_variant_price
    fill_in "Stock count", with: @vendor_variant.stock_count
    fill_in "Vendor", with: @vendor_variant.vendor_id
    fill_in "Vendor product", with: @vendor_variant.vendor_product_id
    click_on "Update Vendor variant"

    assert_text "Vendor variant was successfully updated"
    click_on "Back"
  end

  test "destroying a Vendor variant" do
    visit vendor_variants_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Vendor variant was successfully destroyed"
  end
end
