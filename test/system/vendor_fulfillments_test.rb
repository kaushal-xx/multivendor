require "application_system_test_case"

class VendorFulfillmentsTest < ApplicationSystemTestCase
  setup do
    @vendor_fulfillment = vendor_fulfillments(:one)
  end

  test "visiting the index" do
    visit vendor_fulfillments_url
    assert_selector "h1", text: "Vendor Fulfillments"
  end

  test "creating a Vendor fulfillment" do
    visit vendor_fulfillments_url
    click_on "New Vendor Fulfillment"

    fill_in "Shopify fulfillment count", with: @vendor_fulfillment.shopify_fulfillment_count
    fill_in "Shopify fulfillment data", with: @vendor_fulfillment.shopify_fulfillment_data
    fill_in "Shopify fulfillment status", with: @vendor_fulfillment.shopify_fulfillment_status
    fill_in "Shopify line item", with: @vendor_fulfillment.shopify_line_item_id
    fill_in "Shopify order", with: @vendor_fulfillment.shopify_order_id
    fill_in "Shopify product", with: @vendor_fulfillment.shopify_product_id
    fill_in "Shopify variant", with: @vendor_fulfillment.shopify_variant_id
    fill_in "Shopify variant price", with: @vendor_fulfillment.shopify_variant_price
    fill_in "Vendor", with: @vendor_fulfillment.vendor_id
    fill_in "Vendor order", with: @vendor_fulfillment.vendor_order_id
    click_on "Create Vendor fulfillment"

    assert_text "Vendor fulfillment was successfully created"
    click_on "Back"
  end

  test "updating a Vendor fulfillment" do
    visit vendor_fulfillments_url
    click_on "Edit", match: :first

    fill_in "Shopify fulfillment count", with: @vendor_fulfillment.shopify_fulfillment_count
    fill_in "Shopify fulfillment data", with: @vendor_fulfillment.shopify_fulfillment_data
    fill_in "Shopify fulfillment status", with: @vendor_fulfillment.shopify_fulfillment_status
    fill_in "Shopify line item", with: @vendor_fulfillment.shopify_line_item_id
    fill_in "Shopify order", with: @vendor_fulfillment.shopify_order_id
    fill_in "Shopify product", with: @vendor_fulfillment.shopify_product_id
    fill_in "Shopify variant", with: @vendor_fulfillment.shopify_variant_id
    fill_in "Shopify variant price", with: @vendor_fulfillment.shopify_variant_price
    fill_in "Vendor", with: @vendor_fulfillment.vendor_id
    fill_in "Vendor order", with: @vendor_fulfillment.vendor_order_id
    click_on "Update Vendor fulfillment"

    assert_text "Vendor fulfillment was successfully updated"
    click_on "Back"
  end

  test "destroying a Vendor fulfillment" do
    visit vendor_fulfillments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Vendor fulfillment was successfully destroyed"
  end
end
