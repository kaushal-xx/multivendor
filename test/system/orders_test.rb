require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:one)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "creating a Order" do
    visit orders_url
    click_on "New Order"

    fill_in "Shopify order amount", with: @order.shopify_order_amount
    fill_in "Shopify order data", with: @order.shopify_order_data
    fill_in "Shopify order discount amount", with: @order.shopify_order_discount_amount
    fill_in "Shopify order", with: @order.shopify_order_id
    fill_in "Sme user commission", with: @order.sme_user_commission
    fill_in "Sme user", with: @order.sme_user_id
    click_on "Create Order"

    assert_text "Order was successfully created"
    click_on "Back"
  end

  test "updating a Order" do
    visit orders_url
    click_on "Edit", match: :first

    fill_in "Shopify order amount", with: @order.shopify_order_amount
    fill_in "Shopify order data", with: @order.shopify_order_data
    fill_in "Shopify order discount amount", with: @order.shopify_order_discount_amount
    fill_in "Shopify order", with: @order.shopify_order_id
    fill_in "Sme user commission", with: @order.sme_user_commission
    fill_in "Sme user", with: @order.sme_user_id
    click_on "Update Order"

    assert_text "Order was successfully updated"
    click_on "Back"
  end

  test "destroying a Order" do
    visit orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order was successfully destroyed"
  end
end
