include ActionView::Helpers::NumberHelper

class Cart
  attr_reader :contents, :current_discount, :saved_discounts

  def initialize(contents)
    @contents = contents || {}
    @contents.default = 0
  end

  def add_item(item_id)
    @contents[item_id] += 1
  end

  def less_item(item_id)
    @contents[item_id] -= 1
  end

  def count
    @contents.values.sum
  end

  def items
    @contents.map do |item_id, _|
      Item.find(item_id)
    end
  end

  def display_discounts(item_id)
    item = Item.find(item_id)
    merchant = Merchant.find(item.merchant_id)
    message = String
    if merchant.discounts.empty?
      message = "-----None Available-----"
    else
      merchant.discounts.each do |discount|
        quantity = @contents[item.id.to_s]
        if discount_conditions_met?(item, quantity)
          message = "Congratulations! Your quantity meets this bulk discount"
        else
          message = discount.description
        end
      end
    end
    message
  end

  def grand_total
    @saved_discounts = 0.0
    grand_total = 0.0
    @contents.each do |item_id, quantity|
      item = Item.find(item_id)
      merchant = Merchant.find(item.merchant_id)
      if !merchant.discounts.empty? && discount_conditions_met?(item, quantity)
        discounted_item_total = item.price * quantity
        grand_total += update_cart_with_discounts(@current_discount, discounted_item_total)
      else
        grand_total += item.price * quantity
      end
    end
    grand_total
  end

  def discount_conditions_met?(item, quantity)
    merchant = Merchant.find(item.merchant_id)
    merchant.discounts.each do |discount|
      if quantity >= discount.quantity
        @current_discount = discount
        return true
      else
        return false
      end
    end
  end

  def update_cart_with_discounts(discount, current_total)
    multiplier = (100 - discount.percent).to_f / 100
    updated_total = current_total * multiplier
    @saved_discounts += current_total - updated_total
    updated_total
  end

  def count_of(item_id)
    @contents[item_id.to_s]
  end

  def subtotal_of(item_id)
    @contents[item_id.to_s] * Item.find(item_id).price
  end

  def limit_reached?(item_id)
    count_of(item_id) == Item.find(item_id).inventory
  end
end
