require "rails_helper"

RSpec.describe Discount, type: :model do
  describe "validations" do
    it { should validate_presence_of :description}
    it { should validate_presence_of :quantity}
    it { should validate_presence_of :percent}
    it { should validate_inclusion_of(:enable).in_array([true,false]) }
  end

  describe "relationships" do
    it { should belong_to :merchant}
  end

  describe 'class methods' do
    before :each do
      @magic_box = Merchant.create!(name: 'The Magic Box', address: '123 Main St', city: 'Sunnydale', state: 'CA', zip: 12548)
      @discountthatisenabled_1 = @magic_box.discounts.create!(description:"Buy 5 items, get 15% off", quantity:5, percent:15)
      @discountthatisenabled_2 = @magic_box.discounts.create!(description:"Buy 10 items, get 25% off", quantity:10, percent:25)
      @discountthatisNOTenabled_3 = @magic_box.discounts.create!(description:"Buy 20 items, get 40% off", quantity:20, percent:40, enable:false)
    end

    it '.enabled_discounts' do
      expect(Discount.enabled_discounts).to eq([@discountthatisenabled_1, @discountthatisenabled_2])
    end
  end
end
