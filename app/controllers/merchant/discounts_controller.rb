class Merchant::DiscountsController < Merchant::BaseController
  def index
    @merchant = current_user.merchant
    @discounts = @merchant.discounts
  end

  def update_status
    discount = Discount.find(params[:id])
    if params[:status] == "disable"
      discount.update(enable:false)
    elsif params[:status] == "enable"
      binding.pry
    end
    render :index
  end
end
