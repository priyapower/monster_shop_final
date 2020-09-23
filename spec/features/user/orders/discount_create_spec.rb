require 'rails_helper'

RSpec.describe 'Create a Discounted Order' do
  describe 'As a Registered User' do
    before :each do
      @merchant_1 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @merchant_2 = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @merchant_1.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 500, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 500 )
      @giant = @merchant_1.items.create!(name: 'Giant', description: "I'm a Giant!", price: 650, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 300 )
      @hippo = @merchant_2.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 1500, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 200 )

      @merchant_1_discount_1 = @merchant_1.discounts.create!(description:"Buy 5 items, get 20% off", quantity:5, percent:20)
      @merchant_1_discount_2 = @merchant_1.discounts.create!(description:"Buy 15 items, get 40% off", quantity:15, percent:40)
      @merchant_1_discount_3 = @merchant_1.discounts.create!(description:"Buy 30 items, get 60% off", quantity:30, percent:60)

      @merchant_2_discount_1 = @merchant_2.discounts.create!(description:"Buy 2 items, get 5% off", quantity:2, percent:5)
      @merchant_2_discount_2 = @merchant_2.discounts.create!(description:"Buy 10 items, get 25% off", quantity:10, percent:25)

      @test_user = User.create!(name: 'User Story 18', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'test@user.com', password: 'user')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@test_user)

      30.times do
        visit item_path(@giant)
        click_button 'Add to Cart'
      end
    end

    it 'can see discounts in the cart that track to the order show page' do
      visit '/cart'

      within "#item-#{@giant.id}" do
        expect(page).to have_content("Quantity: 30")
      end

      expect(page).to_not have_content("Total: $19,500.00")
      expect(page).to have_content("Total: $7,800.00")
      expect(page).to have_content("Saved from Discounts: $11,700.00")

      click_button 'Check Out'
      order = Order.last

      expect(current_path).to eq('/profile/orders')
      expect(page).to have_content('Order created successfully!')
      expect(page).to have_link('Cart: 0')

      within "#order-#{order.id}" do
        expect(page).to have_link(order.id)
        expect(page).to have_content("Total: $7,800.00")
        click_link order.id
      end

      expect(page).to have_content("Total: $7,800.00")
    end
  end

  describe "As a regular user - edge test after rails server issue" do
    before :each do
      @sunnydale_high = Merchant.create!(name: "The Sunnydale High Memorial Shop", address: '7340 Junction Avenue', city: 'Sunnydale', state: 'CA', zip: 90344)
      @sunnydale_high.discounts.create!(description:"Buy 5 items, get 20% off", quantity:5, percent:20)
      @trophy = @sunnydale_high.items.create!(name: 'Cheerleader Trophy', description: "This haunted trophy holds the soul of Catherine Madison, a witch who attempted to steal her daughters body to relive her glory days as a cheerleader", price: 350, image: 'https://vignette.wikia.nocookie.net/buffy/images/d/d5/03_51.jpg/revision/latest/scale-to-width-down/340?cb=20081025111301', inventory: 6 )

      @test_user = User.create!(name: 'User Story 18 - Edge Test', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'test@user.com', password: 'user')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@test_user)

    end

    it "can confirm order page has correct total" do
      5.times do
        visit item_path(@trophy)
        click_button 'Add to Cart'
      end

      visit '/cart'

      within "#item-#{@trophy.id}" do
        expect(page).to have_content("Quantity: 5")
      end

      expect(page).to_not have_content("Total: $1,750.00")
      expect(page).to have_content("Total: $1,400.00")
      expect(page).to have_content("Saved from Discounts: $350.00")

      click_button 'Check Out'
      order = Order.last

      expect(current_path).to eq('/profile/orders')
      expect(page).to have_content('Order created successfully!')
      expect(page).to have_link('Cart: 0')

      within "#order-#{order.id}" do
        expect(page).to have_link(order.id)
        expect(page).to have_content("Total: $1,400.00")
        click_link order.id
      end

      expect(page).to have_content("Total: $1,400.00")
    end
  end
end
