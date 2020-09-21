require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
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
      @merchant_1_discount_1 = @merchant_1.discounts.create!(description:"Buy 5 items, get 20% off", quantity:5, percent:20)
      @merchant_1_discount_2 = @merchant_1.discounts.create!(description:"Buy 15 items, get 40% off", quantity:15, percent:40)
      @merchant_1_discount_3 = @merchant_1.discounts.create!(description:"Buy 30 items, get 60% off", quantity:30, percent:60)
      @merchant_2_discount_1 = @merchant_2.discounts.create!(description:"Buy 2 items, get 5% off", quantity:2, percent:5)
      @merchant_2_discount_2 = @merchant_2.discounts.create!(description:"Buy 10 items, get 25% off", quantity:10, percent:25)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@m_user)
    end

    it 'I can see my merchants information on the merchant dashboard' do
      visit '/merchant'

      expect(page).to have_link(@merchant_1.name)
      expect(page).to have_content(@merchant_1.address)
      expect(page).to have_content("#{@merchant_1.city} #{@merchant_1.state} #{@merchant_1.zip}")
    end

    it 'I do not have a link to edit the merchant information' do
      visit '/merchant'

      expect(page).to_not have_link('Edit')
    end

    it 'I see a list of pending orders containing my items' do
      visit '/merchant'

      within '.orders' do
        expect(page).to_not have_css("#order-#{@order_1.id}")

        within "#order-#{@order_2.id}" do
          expect(page).to have_link(@order_2.id)
          expect(page).to have_content("Potential Revenue: #{@order_2.merchant_subtotal(@merchant_1.id)}")
          expect(page).to have_content("Quantity of Items: #{@order_2.merchant_quantity(@merchant_1.id)}")
          expect(page).to have_content("Created: #{@order_2.created_at}")
        end

        within "#order-#{@order_3.id}" do
          expect(page).to have_link(@order_3.id)
          expect(page).to have_content("Potential Revenue: #{@order_3.merchant_subtotal(@merchant_1.id)}")
          expect(page).to have_content("Quantity of Items: #{@order_3.merchant_quantity(@merchant_1.id)}")
          expect(page).to have_content("Created: #{@order_3.created_at}")
        end
      end
    end

    it 'I can link to an order show page' do
      visit '/merchant'

      click_link @order_2.id

      expect(current_path).to eq("/merchant/orders/#{@order_2.id}")
    end

    it "can link to the discounts nested:merchant show page" do
      visit '/merchant'

      expect(page).to have_link("My Discounts")
      click_link("My Discounts")

      expect(current_path).to eq("/merchant/discounts")

      within "#discount-info-#{@merchant_1_discount_1.id}" do
        expect(page).to have_link(@merchant_1_discount_1.id)
        expect(page).to have_button("Delete this Discount")
        expect(@merchant_1_discount_1.enable).to eq(true)
        expect(page).to have_css(check_box "Enable/Disable")
        check("Enable/Disable")
        click_button("Save changes")
        expect(@merchant_1_discount_1.enable).to eq(false)

        expect(page).to_not have_content(@merchant_1_discount_1.description)
        expect(page).to_not have_content(@merchant_1_discount_1.quantity)
        expect(page).to_not have_content(@merchant_1_discount_1.percent)
      end

      within "#discount-info-#{@merchant_1_discount_2.id}" do
        expect(page).to have_link(@merchant_1_discount_2.id)
        expect(page).to have_button("Delete this Discount")
        expect(page).to have_content(@merchant_1_discount_2.enable)
      end

      within "#discount-info-#{@merchant_1_discount_3.id}" do
        expect(page).to have_link(@merchant_1_discount_3.id)
        expect(page).to have_button("Delete this Discount")
        expect(page).to have_content(@merchant_1_discount_3.enable)
        click_link @merchant_1_discount_3.id
        expect(current_path).to eq("/merchant/discounts/#{@merchant_1_discount_3.id}")
      end
    end
  end
end
