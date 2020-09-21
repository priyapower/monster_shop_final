require 'rails_helper'

RSpec.describe 'Cart Show Page - Discounts Visible' do
  describe 'As a Visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @not_visible_merchant = Merchant.create!(name: 'TEST TEST', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @not_visible_item = @not_visible_merchant.items.create!(name: 'Test', description: "I'm a test!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @brian_discount = @brian.discounts.create!(description:"Buy 5 items, get 20% off", quantity:5, percent:20)
      @megan_discount = @megan.discounts.create!(description:"Buy 2 items, get 5% off", quantity:2, percent:5)

      4.times do
        visit "/items/#{@hippo.id}"
        click_on "Add to Cart"
      end

      2.times do
        visit "/items/#{@ogre.id}"
        click_on "Add to Cart"
      end

      visit "/items/#{@giant.id}"
      click_on "Add to Cart"

      visit "/items/#{@not_visible_item.id}"
      click_on "Add to Cart"
    end

    it "can see visible discounts offered by merchant" do
      visit "/cart"

      within "#item-#{@hippo.id}" do
        expect(page).to have_content(@brian_discount.description)
      end

      within "#item-#{@ogre.id}" do
        expect(page).to have_content("Congratulations! Your quantity meets this builk discount")
      end

      within "#item-#{@giant.id}" do
        expect(page).to have_content(@megan_discount.description)
      end

      within "#item-#{@not_visible_item.id}" do
        expect(page).to have_content("----------")
      end

    end
  end
end
