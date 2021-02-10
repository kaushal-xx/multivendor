require "application_system_test_case"

class VendorAddressesTest < ApplicationSystemTestCase
  setup do
    @vendor_address = vendor_addresses(:one)
  end

  test "visiting the index" do
    visit vendor_addresses_url
    assert_selector "h1", text: "Vendor Addresses"
  end

  test "creating a Vendor address" do
    visit vendor_addresses_url
    click_on "New Vendor Address"

    fill_in "Address1", with: @vendor_address.address1
    fill_in "Address2", with: @vendor_address.address2
    fill_in "City", with: @vendor_address.city
    fill_in "Country", with: @vendor_address.country
    fill_in "Google address", with: @vendor_address.google_address
    fill_in "Lat", with: @vendor_address.lat
    fill_in "Lon", with: @vendor_address.lon
    fill_in "Pincode", with: @vendor_address.pincode
    fill_in "State", with: @vendor_address.state
    fill_in "Vendor", with: @vendor_address.vendor_id
    click_on "Create Vendor address"

    assert_text "Vendor address was successfully created"
    click_on "Back"
  end

  test "updating a Vendor address" do
    visit vendor_addresses_url
    click_on "Edit", match: :first

    fill_in "Address1", with: @vendor_address.address1
    fill_in "Address2", with: @vendor_address.address2
    fill_in "City", with: @vendor_address.city
    fill_in "Country", with: @vendor_address.country
    fill_in "Google address", with: @vendor_address.google_address
    fill_in "Lat", with: @vendor_address.lat
    fill_in "Lon", with: @vendor_address.lon
    fill_in "Pincode", with: @vendor_address.pincode
    fill_in "State", with: @vendor_address.state
    fill_in "Vendor", with: @vendor_address.vendor_id
    click_on "Update Vendor address"

    assert_text "Vendor address was successfully updated"
    click_on "Back"
  end

  test "destroying a Vendor address" do
    visit vendor_addresses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Vendor address was successfully destroyed"
  end
end
