require "application_system_test_case"

class VendorProductsTest < ApplicationSystemTestCase
  setup do
    @vendor_product = vendor_products(:one)
  end

  test "visiting the index" do
    visit vendor_products_url
    assert_selector "h1", text: "Vendor Products"
  end

  test "creating a Vendor product" do
    visit vendor_products_url
    click_on "New Vendor Product"

    fill_in "Shopify product data", with: @vendor_product.shopify_product_data
    fill_in "Shopify product", with: @vendor_product.shopify_product_id
    fill_in "Shopify product price", with: @vendor_product.shopify_product_price
    fill_in "Shopify variant", with: @vendor_product.shopify_variant_id
    fill_in "Shopify variant price", with: @vendor_product.shopify_variant_price
    fill_in "Stock count", with: @vendor_product.stock_count
    fill_in "Vendor", with: @vendor_product.vendor_id
    click_on "Create Vendor product"

    assert_text "Vendor product was successfully created"
    click_on "Back"
  end

  test "updating a Vendor product" do
    visit vendor_products_url
    click_on "Edit", match: :first

    fill_in "Shopify product data", with: @vendor_product.shopify_product_data
    fill_in "Shopify product", with: @vendor_product.shopify_product_id
    fill_in "Shopify product price", with: @vendor_product.shopify_product_price
    fill_in "Shopify variant", with: @vendor_product.shopify_variant_id
    fill_in "Shopify variant price", with: @vendor_product.shopify_variant_price
    fill_in "Stock count", with: @vendor_product.stock_count
    fill_in "Vendor", with: @vendor_product.vendor_id
    click_on "Update Vendor product"

    assert_text "Vendor product was successfully updated"
    click_on "Back"
  end

  test "destroying a Vendor product" do
    visit vendor_products_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Vendor product was successfully destroyed"
  end
end
