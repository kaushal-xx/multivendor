require 'test_helper'

class DraftOrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @draft_order = draft_orders(:one)
  end

  test "should get index" do
    get draft_orders_url
    assert_response :success
  end

  test "should get new" do
    get new_draft_order_url
    assert_response :success
  end

  test "should create draft_order" do
    assert_difference('DraftOrder.count') do
      post draft_orders_url, params: { draft_order: { shopify_order_data: @draft_order.shopify_order_data, shopify_order_id: @draft_order.shopify_order_id, sme_user_id: @draft_order.sme_user_id, status: @draft_order.status } }
    end

    assert_redirected_to draft_order_url(DraftOrder.last)
  end

  test "should show draft_order" do
    get draft_order_url(@draft_order)
    assert_response :success
  end

  test "should get edit" do
    get edit_draft_order_url(@draft_order)
    assert_response :success
  end

  test "should update draft_order" do
    patch draft_order_url(@draft_order), params: { draft_order: { shopify_order_data: @draft_order.shopify_order_data, shopify_order_id: @draft_order.shopify_order_id, sme_user_id: @draft_order.sme_user_id, status: @draft_order.status } }
    assert_redirected_to draft_order_url(@draft_order)
  end

  test "should destroy draft_order" do
    assert_difference('DraftOrder.count', -1) do
      delete draft_order_url(@draft_order)
    end

    assert_redirected_to draft_orders_url
  end
end
