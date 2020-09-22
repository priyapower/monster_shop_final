require 'rails_helper'

RSpec.describe 'Discounted Cart Show Page' do
  describe 'As a non-admin user' do
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

      4.times do
        visit item_path(@ogre)
        click_button 'Add to Cart'
      end

      visit item_path(@hippo)
      click_button 'Add to Cart'
    end

    it "can see updated totals in cart when a discount is met" do
      visit '/cart'

      within "#item-#{@ogre.id}" do
        expect(page).to have_content("Quantity: 4")
      end

      within "#item-#{@hippo.id}" do
        expect(page).to have_content("Quantity: 1")
      end

      expect(page).to have_content("Total: $3,500.00")

      within "#item-#{@hippo.id}" do
        click_button('More of This!')
      end

      within "#item-#{@hippo.id}" do
        expect(page).to have_content("Quantity: 2")
      end

      expect(page).to_not have_content("Total: $5,000.00")
      expect(page).to have_content("Total: $4,850.00")
      expect(page).to have_content("Saved from Discounts: $150.00")
    end

    it "can remove discount if items are decreased" do
      visit '/cart'

      expect(page).to have_content("Total: $3,500.00")

      within "#item-#{@ogre.id}" do
        click_button('More of This!')
      end

      within "#item-#{@ogre.id}" do
        expect(page).to have_content("Quantity: 5")
      end

      expect(page).to_not have_content("Total: $4,000.00")
      expect(page).to have_content("Total: $3,500.00")
      expect(page).to have_content("Saved from Discounts: $500.00")

      within "#item-#{@ogre.id}" do
        click_button('Less of This!')
      end

      within "#item-#{@ogre.id}" do
        expect(page).to have_content("Quantity: 4")
      end

      expect(page).to have_content("Total: $3,500.00")
      expect(page).to_not have_content("Saved from Discounts:")
    end

    it "can see possible merchant discount (the least quantity one) in cart" do
      visit '/cart'
      within "#item-#{@ogre.id}" do
        expect(page).to have_content("Possible Merchant Discounts: #{@merchant_1_discount_1.description}")
      end

      within "#item-#{@hippo.id}" do
        expect(page).to have_content("Possible Merchant Discounts: #{@merchant_2_discount_1.description}")
      end
    end

    it "can discount multiple qualifying items from multiple merchants" do
      visit '/cart'

      expect(page).to have_content("Total: $3,500.00")

      within "#item-#{@ogre.id}" do
        click_button('More of This!')
      end

      within "#item-#{@ogre.id}" do
        expect(page).to have_content("Quantity: 5")
      end

      within "#item-#{@hippo.id}" do
        click_button('More of This!')
      end

      within "#item-#{@hippo.id}" do
        expect(page).to have_content("Quantity: 2")
      end

      expect(page).to_not have_content("Total: $5,500.00")
      expect(page).to have_content("Total: $4,850.00")
      expect(page).to have_content("Saved from Discounts: $650.00")
    end

    it "can discount only bulk quantity items and not normal merchant items" do
    end

    it "can only apply the greater discount when more than one conflict"
  end
end
