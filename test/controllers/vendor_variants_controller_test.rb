require 'test_helper'

class VendorVariantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vendor_variant = vendor_variants(:one)
  end

  test "should get index" do
    get vendor_variants_url
    assert_response :success
  end

  test "should get new" do
    get new_vendor_variant_url
    assert_response :success
  end

  test "should create vendor_variant" do
    assert_difference('VendorVariant.count') do
      post vendor_variants_url, params: { vendor_variant: { shopify_product_id: @vendor_variant.shopify_product_id, shopify_variant_data: @vendor_variant.shopify_variant_data, shopify_variant_id: @vendor_variant.shopify_variant_id, shopify_variant_price: @vendor_variant.shopify_variant_price, stock_count: @vendor_variant.stock_count, vendor_id: @vendor_variant.vendor_id, vendor_product_id: @vendor_variant.vendor_product_id } }
    end

    assert_redirected_to vendor_variant_url(VendorVariant.last)
  end

  test "should show vendor_variant" do
    get vendor_variant_url(@vendor_variant)
    assert_response :success
  end

  test "should get edit" do
    get edit_vendor_variant_url(@vendor_variant)
    assert_response :success
  end

  test "should update vendor_variant" do
    patch vendor_variant_url(@vendor_variant), params: { vendor_variant: { shopify_product_id: @vendor_variant.shopify_product_id, shopify_variant_data: @vendor_variant.shopify_variant_data, shopify_variant_id: @vendor_variant.shopify_variant_id, shopify_variant_price: @vendor_variant.shopify_variant_price, stock_count: @vendor_variant.stock_count, vendor_id: @vendor_variant.vendor_id, vendor_product_id: @vendor_variant.vendor_product_id } }
    assert_redirected_to vendor_variant_url(@vendor_variant)
  end

  test "should destroy vendor_variant" do
    assert_difference('VendorVariant.count', -1) do
      delete vendor_variant_url(@vendor_variant)
    end

    assert_redirected_to vendor_variants_url
  end
end
