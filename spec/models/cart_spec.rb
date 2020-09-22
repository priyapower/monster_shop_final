require 'rails_helper'

RSpec.describe Cart do
  describe 'Instance Methods' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 2 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 25 )
      @discount_test = @brian.discounts.create!(description:"Buy 5 items, get 20% off", quantity:5, percent:20)
      @cart = Cart.new({
        @ogre.id.to_s => 1,
        @giant.id.to_s => 2
        })
      @cart_2 = Cart.new({
        @hippo.id.to_s => 4
        })
    end

    it "#displays_discounts()" do
      expect(@cart_2.display_discounts(@hippo.id)).to eq("Buy 5 items, get 20% off")
      expect(@cart.display_discounts(@ogre.id)).to eq("-----None Available-----")
      @cart_2.add_item(@hippo.id.to_s)
      expect(@cart_2.display_discounts(@hippo.id)).to eq("Congratulations! Your quantity meets this bulk discount")
    end

    it '.grand_total' do
      expect(@cart.grand_total).to eq(120)
    end

    #Discount updates grand_total
    it '.grand_total' do
      expect(@cart_2.contents).to eq({
        @hippo.id.to_s => 4
        })
        expect(@cart_2.grand_total).to eq(200)
        @cart_2.add_item(@hippo.id.to_s)
        expect(@cart_2.grand_total).to eq(200)
    end

    # it '#update_cart_with_discounts()' do
    #   # Can NO longer be tested individually, since a cart specific variable is called
    #   expect(@cart_2.update_cart_with_discounts(@discount_test, 250)).to eq(200)
    # end

    it '#discount_conditions_met?()' do
      expect(@cart_2.discount_conditions_met?(@hippo, 5)).to eq(true)
    end

    it '.contents' do
      expect(@cart.contents).to eq({
        @ogre.id.to_s => 1,
        @giant.id.to_s => 2
        })
    end

    it '.add_item()' do
      @cart.add_item(@hippo.id.to_s)

      expect(@cart.contents).to eq({
        @ogre.id.to_s => 1,
        @giant.id.to_s => 2,
        @hippo.id.to_s => 1
        })
    end

    it '.count' do
      expect(@cart.count).to eq(3)
    end

    it '.items' do
      expect(@cart.items).to eq([@ogre, @giant])
    end

    it '.count_of()' do
      expect(@cart.count_of(@ogre.id)).to eq(1)
      expect(@cart.count_of(@giant.id)).to eq(2)
    end

    it '.subtotal_of()' do
      expect(@cart.subtotal_of(@ogre.id)).to eq(20)
      expect(@cart.subtotal_of(@giant.id)).to eq(100)
    end

    it '.limit_reached?()' do
      expect(@cart.limit_reached?(@ogre.id)).to eq(false)
      expect(@cart.limit_reached?(@giant.id)).to eq(true)
    end

    it '.less_item()' do
      @cart.less_item(@giant.id.to_s)

      expect(@cart.count_of(@giant.id)).to eq(1)
    end
  end
end
