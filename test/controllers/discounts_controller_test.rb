require 'test_helper'

class DiscountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @discount = discounts(:one)
  end

  test "should get index" do
    get discounts_url
    assert_response :success
  end

  test "should get new" do
    get new_discount_url
    assert_response :success
  end

  test "should create discount" do
    assert_difference('Discount.count') do
      post discounts_url, params: { discount: { active: @discount.active, shopify_discount_code: @discount.shopify_discount_code, shopify_discount_data: @discount.shopify_discount_data, shopify_discount_id: @discount.shopify_discount_id, shopify_discount_presents: @discount.shopify_discount_presents, sme_user_id: @discount.sme_user_id } }
    end

    assert_redirected_to discount_url(Discount.last)
  end

  test "should show discount" do
    get discount_url(@discount)
    assert_response :success
  end

  test "should get edit" do
    get edit_discount_url(@discount)
    assert_response :success
  end

  test "should update discount" do
    patch discount_url(@discount), params: { discount: { active: @discount.active, shopify_discount_code: @discount.shopify_discount_code, shopify_discount_data: @discount.shopify_discount_data, shopify_discount_id: @discount.shopify_discount_id, shopify_discount_presents: @discount.shopify_discount_presents, sme_user_id: @discount.sme_user_id } }
    assert_redirected_to discount_url(@discount)
  end

  test "should destroy discount" do
    assert_difference('Discount.count', -1) do
      delete discount_url(@discount)
    end

    assert_redirected_to discounts_url
  end
end
