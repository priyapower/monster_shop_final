require 'rails_helper'

RSpec.describe 'Discounts Show Page under Merchant Dashboard' do
  describe 'As an employee of a merchant' do
    before :each do
      @merchant_1 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @merchant_2 = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @m_user = @merchant_1.users.create(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'megan@example.com', password: 'securepassword')
      @ogre = @merchant_1.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @merchant_1.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @merchant_2.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 1 )
      @order_1 = @m_user.orders.create!(status: "pending")
      @order_2 = @m_user.orders.create!(status: "pending")
      @order_3 = @m_user.orders.create!(status: "pending")
      @order_item_1 = @order_1.order_items.create!(item: @hippo, price: @hippo.price, quantity: 2, fulfilled: false)
      @order_item_2 = @order_2.order_items.create!(item: @hippo, price: @hippo.price, quantity: 2, fulfilled: true)
      @order_item_3 = @order_2.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2, fulfilled: false)
      @order_item_4 = @order_3.order_items.create!(item: @giant, price: @giant.price, quantity: 2, fulfilled: false)
      @merchant_1_discount_1 = @merchant_1.discounts.create!(description:"Buy 5 items, get 20% off", quantity:5, percent:20, enable:false)
      @merchant_1_discount_2 = @merchant_1.discounts.create!(description:"Buy 15 items, get 40% off", quantity:15, percent:40)
      @merchant_1_discount_3 = @merchant_1.discounts.create!(description:"Buy 30 items, get 60% off", quantity:30, percent:60)
      @merchant_2_discount_1 = @merchant_2.discounts.create!(description:"Buy 2 items, get 5% off", quantity:2, percent:5)
      @merchant_2_discount_2 = @merchant_2.discounts.create!(description:"Buy 10 items, get 25% off", quantity:10, percent:25)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@m_user)
    end

    it "can edit a discount" do
      visit "/merchant/discounts/#{@merchant_1_discount_1.id}"
      expect(page).to have_button("Edit this Discount")
      click_button("Edit this Discount")

      expect(current_path).to eq("/merchant/discounts/#{@merchant_1_discount_1.id}/edit")
      expect(page).to have_field(:description, with: @merchant_1_discount_1.description)

      new_description = "Buy 7 items, get 20% off"
      new_quantity = 7
      fill_in :description, with: new_description
      fill_in :quantity, with: new_quantity

      click_on "Update this Discount"
      expect(current_path).to eq("/merchant/discounts/#{@merchant_1_discount_1.id}")

      expect(page).to have_content("Description: #{new_description}")
      expect(page).to have_content("Minimum Quantity: #{new_quantity}")
      expect(page).to have_content("Percent Off: #{@merchant_1_discount_1.percent}%")
    end

    it "can see a flash error message if any fields missing" do
      visit "/merchant/discounts/#{@merchant_1_discount_2.id}"
      click_button("Edit this Discount")
      expect(current_path).to eq("/merchant/discounts/#{@merchant_1_discount_2.id}/edit")

      blank_test = ""
      new_quantity = 50
      fill_in :description, with: blank_test
      fill_in :quantity, with: new_quantity

      click_on "Update this Discount"
      expect(page).to have_content("description: [\"can't be blank\"]")
    end
  end
end
