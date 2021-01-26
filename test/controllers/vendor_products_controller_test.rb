require 'test_helper'

class VendorProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vendor_product = vendor_products(:one)
  end

  test "should get index" do
    get vendor_products_url
    assert_response :success
  end

  test "should get new" do
    get new_vendor_product_url
    assert_response :success
  end

  test "should create vendor_product" do
    assert_difference('VendorProduct.count') do
      post vendor_products_url, params: { vendor_product: { shopify_product_data: @vendor_product.shopify_product_data, shopify_product_id: @vendor_product.shopify_product_id, shopify_product_price: @vendor_product.shopify_product_price, shopify_variant_id: @vendor_product.shopify_variant_id, shopify_variant_price: @vendor_product.shopify_variant_price, stock_count: @vendor_product.stock_count, vendor_id: @vendor_product.vendor_id } }
    end

    assert_redirected_to vendor_product_url(VendorProduct.last)
  end

  test "should show vendor_product" do
    get vendor_product_url(@vendor_product)
    assert_response :success
  end

  test "should get edit" do
    get edit_vendor_product_url(@vendor_product)
    assert_response :success
  end

  test "should update vendor_product" do
    patch vendor_product_url(@vendor_product), params: { vendor_product: { shopify_product_data: @vendor_product.shopify_product_data, shopify_product_id: @vendor_product.shopify_product_id, shopify_product_price: @vendor_product.shopify_product_price, shopify_variant_id: @vendor_product.shopify_variant_id, shopify_variant_price: @vendor_product.shopify_variant_price, stock_count: @vendor_product.stock_count, vendor_id: @vendor_product.vendor_id } }
    assert_redirected_to vendor_product_url(@vendor_product)
  end

  test "should destroy vendor_product" do
    assert_difference('VendorProduct.count', -1) do
      delete vendor_product_url(@vendor_product)
    end

    assert_redirected_to vendor_products_url
  end
end
