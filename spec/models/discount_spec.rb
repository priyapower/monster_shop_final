require "rails_helper"

RSpec.describe Discount, type: :model do
  describe "validations" do
    it { should validate_presence_of :description}
    it { should validate_presence_of :quantity}
    it { should validate_presence_of :percent}
    it { should validate_presence_of :enabled}
  end

  describe "relationships" do
    it { should belong_to :merchants}
  end

  # describe 'class methods' do
  #   before :each do
  #     @discountthatisenabled_1
  #     @discountthatisenabled_2
  #     @discountthatisNOTenabled_3
  #   end
  #
  #   it '.enabled_discounts' do
  #     expect(Discount.enabled_discounts).to eq([@discountthatisenabled_1, @discountthatisenabled_2])
  #   end
  # end
end







describe 'Class Methods' do
  before :each do
    @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
    @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
    @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
    @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
    @nessie = @brian.items.create!(name: 'Nessie', description: "I'm a Loch Monster!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: false, inventory: 3 )
    @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Loch Monster!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: false, inventory: 3 )
    @gator = @brian.items.create!(name: 'Gator', description: "I'm a Loch Monster!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: false, inventory: 3 )
    @review_1 = @ogre.reviews.create(title: 'Great!', description: 'This Ogre is Great!', rating: 5)
    @review_2 = @ogre.reviews.create(title: 'Meh.', description: 'This Ogre is Mediocre', rating: 3)
    @review_3 = @ogre.reviews.create(title: 'EW', description: 'This Ogre is Ew', rating: 1)
    @review_4 = @ogre.reviews.create(title: 'So So', description: 'This Ogre is So so', rating: 2)
    @review_5 = @ogre.reviews.create(title: 'Okay', description: 'This Ogre is Okay', rating: 4)
    @user = User.create!(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'megan@example.com', password: 'securepassword')
    @order_1 = @user.orders.create!
    @order_2 = @user.orders.create!
    @order_3 = @user.orders.create!
    @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2)
    @order_1.order_items.create!(item: @hippo, price: @hippo.price, quantity: 3)
    @order_2.order_items.create!(item: @hippo, price: @hippo.price, quantity: 5)
    @order_3.order_items.create!(item: @nessie, price: @nessie.price, quantity: 7)
    @order_3.order_items.create!(item: @gator, price: @gator.price, quantity: 1)
  end
