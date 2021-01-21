require "application_system_test_case"

class DiscountsTest < ApplicationSystemTestCase
  setup do
    @discount = discounts(:one)
  end

  test "visiting the index" do
    visit discounts_url
    assert_selector "h1", text: "Discounts"
  end

  test "creating a Discount" do
    visit discounts_url
    click_on "New Discount"

    check "Active" if @discount.active
    fill_in "Shopify discount code", with: @discount.shopify_discount_code
    fill_in "Shopify discount data", with: @discount.shopify_discount_data
    fill_in "Shopify discount", with: @discount.shopify_discount_id
    fill_in "Shopify discount presents", with: @discount.shopify_discount_presents
    fill_in "Sme user", with: @discount.sme_user_id
    click_on "Create Discount"

    assert_text "Discount was successfully created"
    click_on "Back"
  end

  test "updating a Discount" do
    visit discounts_url
    click_on "Edit", match: :first

    check "Active" if @discount.active
    fill_in "Shopify discount code", with: @discount.shopify_discount_code
    fill_in "Shopify discount data", with: @discount.shopify_discount_data
    fill_in "Shopify discount", with: @discount.shopify_discount_id
    fill_in "Shopify discount presents", with: @discount.shopify_discount_presents
    fill_in "Sme user", with: @discount.sme_user_id
    click_on "Update Discount"

    assert_text "Discount was successfully updated"
    click_on "Back"
  end

  test "destroying a Discount" do
    visit discounts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Discount was successfully destroyed"
  end
end
