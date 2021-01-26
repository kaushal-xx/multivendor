require 'test_helper'

class VendorFulfillmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vendor_fulfillment = vendor_fulfillments(:one)
  end

  test "should get index" do
    get vendor_fulfillments_url
    assert_response :success
  end

  test "should get new" do
    get new_vendor_fulfillment_url
    assert_response :success
  end

  test "should create vendor_fulfillment" do
    assert_difference('VendorFulfillment.count') do
      post vendor_fulfillments_url, params: { vendor_fulfillment: { shopify_fulfillment_count: @vendor_fulfillment.shopify_fulfillment_count, shopify_fulfillment_data: @vendor_fulfillment.shopify_fulfillment_data, shopify_fulfillment_status: @vendor_fulfillment.shopify_fulfillment_status, shopify_line_item_id: @vendor_fulfillment.shopify_line_item_id, shopify_order_id: @vendor_fulfillment.shopify_order_id, shopify_product_id: @vendor_fulfillment.shopify_product_id, shopify_variant_id: @vendor_fulfillment.shopify_variant_id, shopify_variant_price: @vendor_fulfillment.shopify_variant_price, vendor_id: @vendor_fulfillment.vendor_id, vendor_order_id: @vendor_fulfillment.vendor_order_id } }
    end

    assert_redirected_to vendor_fulfillment_url(VendorFulfillment.last)
  end

  test "should show vendor_fulfillment" do
    get vendor_fulfillment_url(@vendor_fulfillment)
    assert_response :success
  end

  test "should get edit" do
    get edit_vendor_fulfillment_url(@vendor_fulfillment)
    assert_response :success
  end

  test "should update vendor_fulfillment" do
    patch vendor_fulfillment_url(@vendor_fulfillment), params: { vendor_fulfillment: { shopify_fulfillment_count: @vendor_fulfillment.shopify_fulfillment_count, shopify_fulfillment_data: @vendor_fulfillment.shopify_fulfillment_data, shopify_fulfillment_status: @vendor_fulfillment.shopify_fulfillment_status, shopify_line_item_id: @vendor_fulfillment.shopify_line_item_id, shopify_order_id: @vendor_fulfillment.shopify_order_id, shopify_product_id: @vendor_fulfillment.shopify_product_id, shopify_variant_id: @vendor_fulfillment.shopify_variant_id, shopify_variant_price: @vendor_fulfillment.shopify_variant_price, vendor_id: @vendor_fulfillment.vendor_id, vendor_order_id: @vendor_fulfillment.vendor_order_id } }
    assert_redirected_to vendor_fulfillment_url(@vendor_fulfillment)
  end

  test "should destroy vendor_fulfillment" do
    assert_difference('VendorFulfillment.count', -1) do
      delete vendor_fulfillment_url(@vendor_fulfillment)
    end

    assert_redirected_to vendor_fulfillments_url
  end
end
