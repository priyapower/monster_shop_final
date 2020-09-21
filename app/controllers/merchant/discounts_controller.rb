class Merchant::DiscountsController < Merchant::BaseController
  def index
    @merchant = current_user.merchant
    @discounts = @merchant.discounts
  end
end
