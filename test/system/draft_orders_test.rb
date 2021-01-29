require "application_system_test_case"

class DraftOrdersTest < ApplicationSystemTestCase
  setup do
    @draft_order = draft_orders(:one)
  end

  test "visiting the index" do
    visit draft_orders_url
    assert_selector "h1", text: "Draft Orders"
  end

  test "creating a Draft order" do
    visit draft_orders_url
    click_on "New Draft Order"

    fill_in "Shopify order data", with: @draft_order.shopify_order_data
    fill_in "Shopify order", with: @draft_order.shopify_order_id
    fill_in "Sme user", with: @draft_order.sme_user_id
    fill_in "Status", with: @draft_order.status
    click_on "Create Draft order"

    assert_text "Draft order was successfully created"
    click_on "Back"
  end

  test "updating a Draft order" do
    visit draft_orders_url
    click_on "Edit", match: :first

    fill_in "Shopify order data", with: @draft_order.shopify_order_data
    fill_in "Shopify order", with: @draft_order.shopify_order_id
    fill_in "Sme user", with: @draft_order.sme_user_id
    fill_in "Status", with: @draft_order.status
    click_on "Update Draft order"

    assert_text "Draft order was successfully updated"
    click_on "Back"
  end

  test "destroying a Draft order" do
    visit draft_orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Draft order was successfully destroyed"
  end
end
