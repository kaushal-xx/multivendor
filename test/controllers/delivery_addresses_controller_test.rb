require 'test_helper'

class DeliveryAddressesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @delivery_address = delivery_addresses(:one)
  end

  test "should get index" do
    get delivery_addresses_url
    assert_response :success
  end

  test "should get new" do
    get new_delivery_address_url
    assert_response :success
  end

  test "should create delivery_address" do
    assert_difference('DeliveryAddress.count') do
      post delivery_addresses_url, params: { delivery_address: { address1: @delivery_address.address1, address2: @delivery_address.address2, city: @delivery_address.city, country: @delivery_address.country, google_address: @delivery_address.google_address, lat: @delivery_address.lat, lon: @delivery_address.lon, pincode: @delivery_address.pincode, state: @delivery_address.state } }
    end

    assert_redirected_to delivery_address_url(DeliveryAddress.last)
  end

  test "should show delivery_address" do
    get delivery_address_url(@delivery_address)
    assert_response :success
  end

  test "should get edit" do
    get edit_delivery_address_url(@delivery_address)
    assert_response :success
  end

  test "should update delivery_address" do
    patch delivery_address_url(@delivery_address), params: { delivery_address: { address1: @delivery_address.address1, address2: @delivery_address.address2, city: @delivery_address.city, country: @delivery_address.country, google_address: @delivery_address.google_address, lat: @delivery_address.lat, lon: @delivery_address.lon, pincode: @delivery_address.pincode, state: @delivery_address.state } }
    assert_redirected_to delivery_address_url(@delivery_address)
  end

  test "should destroy delivery_address" do
    assert_difference('DeliveryAddress.count', -1) do
      delete delivery_address_url(@delivery_address)
    end

    assert_redirected_to delivery_addresses_url
  end
end
