class Merchant::DiscountsController < Merchant::BaseController

  def index
    @merchant = current_user.merchant
    @discounts = @merchant.discounts
  end

  def destroy
    merchant = current_user.merchant
    discount = Discount.find(params[:id])
    merchant.discounts.destroy(discount.id)
    discount.destroy
    redirect_to "/merchant/discounts"
  end

  def edit
    @discount = Discount.find(params[:id])
  end

  def new

  end

  def create
    merchant = current_user.merchant
    discount = merchant.discounts.new(discount_params)
    if discount.save
      redirect_to "/merchant/discounts"
    else
      generate_flash(discount)
      render :new
    end
  end

  def show
    @discount = Discount.find(params[:id])
  end

  def update
    @discount = Discount.find(params[:id])
    if @discount.update(discount_params)
      redirect_to "/merchant/discounts/#{@discount.id}"
    else
      generate_flash(@discount)
      render :edit
    end
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

  private

  def discount_params
    params.permit(:description, :quantity, :percent)
  end

end
