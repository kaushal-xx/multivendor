require 'test_helper'

class VendorAddressesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vendor_address = vendor_addresses(:one)
  end

  test "should get index" do
    get vendor_addresses_url
    assert_response :success
  end

  test "should get new" do
    get new_vendor_address_url
    assert_response :success
  end

  test "should create vendor_address" do
    assert_difference('VendorAddress.count') do
      post vendor_addresses_url, params: { vendor_address: { address1: @vendor_address.address1, address2: @vendor_address.address2, city: @vendor_address.city, country: @vendor_address.country, google_address: @vendor_address.google_address, lat: @vendor_address.lat, lon: @vendor_address.lon, pincode: @vendor_address.pincode, state: @vendor_address.state, vendor_id: @vendor_address.vendor_id } }
    end

    assert_redirected_to vendor_address_url(VendorAddress.last)
  end

  test "should show vendor_address" do
    get vendor_address_url(@vendor_address)
    assert_response :success
  end

  test "should get edit" do
    get edit_vendor_address_url(@vendor_address)
    assert_response :success
  end

  test "should update vendor_address" do
    patch vendor_address_url(@vendor_address), params: { vendor_address: { address1: @vendor_address.address1, address2: @vendor_address.address2, city: @vendor_address.city, country: @vendor_address.country, google_address: @vendor_address.google_address, lat: @vendor_address.lat, lon: @vendor_address.lon, pincode: @vendor_address.pincode, state: @vendor_address.state, vendor_id: @vendor_address.vendor_id } }
    assert_redirected_to vendor_address_url(@vendor_address)
  end

  test "should destroy vendor_address" do
    assert_difference('VendorAddress.count', -1) do
      delete vendor_address_url(@vendor_address)
    end

    assert_redirected_to vendor_addresses_url
  end
end
