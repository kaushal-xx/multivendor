require "application_system_test_case"

class DeliveryAddressesTest < ApplicationSystemTestCase
  setup do
    @delivery_address = delivery_addresses(:one)
  end

  test "visiting the index" do
    visit delivery_addresses_url
    assert_selector "h1", text: "Delivery Addresses"
  end

  test "creating a Delivery address" do
    visit delivery_addresses_url
    click_on "New Delivery Address"

    fill_in "Address1", with: @delivery_address.address1
    fill_in "Address2", with: @delivery_address.address2
    fill_in "City", with: @delivery_address.city
    fill_in "Country", with: @delivery_address.country
    fill_in "Google address", with: @delivery_address.google_address
    fill_in "Lat", with: @delivery_address.lat
    fill_in "Lon", with: @delivery_address.lon
    fill_in "Pincode", with: @delivery_address.pincode
    fill_in "State", with: @delivery_address.state
    click_on "Create Delivery address"

    assert_text "Delivery address was successfully created"
    click_on "Back"
  end

  test "updating a Delivery address" do
    visit delivery_addresses_url
    click_on "Edit", match: :first

    fill_in "Address1", with: @delivery_address.address1
    fill_in "Address2", with: @delivery_address.address2
    fill_in "City", with: @delivery_address.city
    fill_in "Country", with: @delivery_address.country
    fill_in "Google address", with: @delivery_address.google_address
    fill_in "Lat", with: @delivery_address.lat
    fill_in "Lon", with: @delivery_address.lon
    fill_in "Pincode", with: @delivery_address.pincode
    fill_in "State", with: @delivery_address.state
    click_on "Update Delivery address"

    assert_text "Delivery address was successfully updated"
    click_on "Back"
  end

  test "destroying a Delivery address" do
    visit delivery_addresses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Delivery address was successfully destroyed"
  end
end
