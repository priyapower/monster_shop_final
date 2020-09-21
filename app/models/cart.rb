include ActionView::Helpers::NumberHelper

class Cart
  attr_reader :contents

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

  def grand_total
    grand_total = 0.0
    @contents.each do |item_id, quantity|
      item = Item.find(item_id)
      merchant = Merchant.find(item.merchant_id)
      grand_total += item.price * quantity
      if !merchant.discounts.empty? && discount_conditions_met?(item, quantity, grand_total)
        grand_total = update_cart_with_discounts(merchant, grand_total)
      end
    end
    grand_total
  end

  def discount_conditions_met?(item, quantity, current_total)
    merchant = Merchant.find(item.merchant_id)
    merchant.discounts.each do |discount|
      if quantity >= discount.quantity
        return true
      else
        return false
      end
    end
  end

  def update_cart_with_discounts(merchant, current_total)
    merchant.discounts.each do |discount|
      multiplier = (100 - discount.percent).to_f / 100
      current_total = current_total * multiplier
    end
    current_total
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
