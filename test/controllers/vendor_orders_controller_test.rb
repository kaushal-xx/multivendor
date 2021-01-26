require 'test_helper'

class VendorOrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vendor_order = vendor_orders(:one)
  end

  test "should get index" do
    get vendor_orders_url
    assert_response :success
  end

  test "should get new" do
    get new_vendor_order_url
    assert_response :success
  end

  test "should create vendor_order" do
    assert_difference('VendorOrder.count') do
      post vendor_orders_url, params: { vendor_order: { product_id: @vendor_order.product_id, shopify_order_amount: @vendor_order.shopify_order_amount, shopify_order_data: @vendor_order.shopify_order_data, shopify_order_id: @vendor_order.shopify_order_id, shopify_order_status: @vendor_order.shopify_order_status, shopify_product_id: @vendor_order.shopify_product_id, shopify_product_quantity: @vendor_order.shopify_product_quantity, shopify_variant_id: @vendor_order.shopify_variant_id, vendor_id: @vendor_order.vendor_id } }
    end

    assert_redirected_to vendor_order_url(VendorOrder.last)
  end

  test "should show vendor_order" do
    get vendor_order_url(@vendor_order)
    assert_response :success
  end

  test "should get edit" do
    get edit_vendor_order_url(@vendor_order)
    assert_response :success
  end

  test "should update vendor_order" do
    patch vendor_order_url(@vendor_order), params: { vendor_order: { product_id: @vendor_order.product_id, shopify_order_amount: @vendor_order.shopify_order_amount, shopify_order_data: @vendor_order.shopify_order_data, shopify_order_id: @vendor_order.shopify_order_id, shopify_order_status: @vendor_order.shopify_order_status, shopify_product_id: @vendor_order.shopify_product_id, shopify_product_quantity: @vendor_order.shopify_product_quantity, shopify_variant_id: @vendor_order.shopify_variant_id, vendor_id: @vendor_order.vendor_id } }
    assert_redirected_to vendor_order_url(@vendor_order)
  end

  test "should destroy vendor_order" do
    assert_difference('VendorOrder.count', -1) do
      delete vendor_order_url(@vendor_order)
    end

    assert_redirected_to vendor_orders_url
  end
end
