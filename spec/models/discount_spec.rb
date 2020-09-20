require "rails_helper"

RSpec.describe Discount, type: :model do
  describe "validations" do
    it { should validate_presence_of :description}
    it { should validate_presence_of :quantity}
    it { should validate_presence_of :percent}
    it { should validate_presence_of :enabled}
  end

  describe "relationships" do
    it { should belong_to :merchant}
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
