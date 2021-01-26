require "application_system_test_case"

class VendorOrdersTest < ApplicationSystemTestCase
  setup do
    @vendor_order = vendor_orders(:one)
  end

  test "visiting the index" do
    visit vendor_orders_url
    assert_selector "h1", text: "Vendor Orders"
  end

  test "creating a Vendor order" do
    visit vendor_orders_url
    click_on "New Vendor Order"

    fill_in "Product", with: @vendor_order.product_id
    fill_in "Shopify order amount", with: @vendor_order.shopify_order_amount
    fill_in "Shopify order data", with: @vendor_order.shopify_order_data
    fill_in "Shopify order", with: @vendor_order.shopify_order_id
    fill_in "Shopify order status", with: @vendor_order.shopify_order_status
    fill_in "Shopify product", with: @vendor_order.shopify_product_id
    fill_in "Shopify product quantity", with: @vendor_order.shopify_product_quantity
    fill_in "Shopify variant", with: @vendor_order.shopify_variant_id
    fill_in "Vendor", with: @vendor_order.vendor_id
    click_on "Create Vendor order"

    assert_text "Vendor order was successfully created"
    click_on "Back"
  end

  test "updating a Vendor order" do
    visit vendor_orders_url
    click_on "Edit", match: :first

    fill_in "Product", with: @vendor_order.product_id
    fill_in "Shopify order amount", with: @vendor_order.shopify_order_amount
    fill_in "Shopify order data", with: @vendor_order.shopify_order_data
    fill_in "Shopify order", with: @vendor_order.shopify_order_id
    fill_in "Shopify order status", with: @vendor_order.shopify_order_status
    fill_in "Shopify product", with: @vendor_order.shopify_product_id
    fill_in "Shopify product quantity", with: @vendor_order.shopify_product_quantity
    fill_in "Shopify variant", with: @vendor_order.shopify_variant_id
    fill_in "Vendor", with: @vendor_order.vendor_id
    click_on "Update Vendor order"

    assert_text "Vendor order was successfully updated"
    click_on "Back"
  end

  test "destroying a Vendor order" do
    visit vendor_orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Vendor order was successfully destroyed"
  end
end
