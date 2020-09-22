class Merchant::DiscountsController < Merchant::BaseController

  def index
    @merchant = current_user.merchant
    @discounts = @merchant.discounts
  end

  def show
    @discount = Discount.find(params[:id])
  end
  # def update_status
  #   discount = Discount.find(params[:id])
  #   if params[:status] == "disable"
  #     discount.update!(enable:false)
  #   elsif params[:status] == "enable"
  #     discount.update!(enable:true)
  #   end
  #   redirect_to request.referer
  # end

  # def update_status
  #   discount = Discount.find(params[:id])
  #   if params[:status] == "disable"
  #     Discount.where(id:discount.id).update(enable:false)
  #   elsif params[:status] == "enable"
  #     Discount.where(id:discount.id).update(enable:true)
  #   end
  #   redirect_to request.referer
  # end

  # private
  #
  # def discount_params
  #   params.permit(:description, :quantity, :percent, :enable)
  # end

end
