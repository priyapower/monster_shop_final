class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :user

  enum status: ['pending', 'packaged', 'shipped', 'cancelled']

  def grand_total
    grand_total = 0.0
    hash_to_check_discounts = Hash.new
    order_items.pluck(:item_id).each do |item_id|
      item = Item.find(item_id)
      quantity = order_items.where(item:item).pluck(:quantity)[0]
      discounts = item.merchant.discounts

      if !discounts.empty?
        discounts.each do |discount|
          multiplier = (100 - discount.percent).to_f / 100
          current_total = item.price * quantity
          discounted_total = current_total * multiplier
          hash_to_check_discounts[discount.id] = current_total - discounted_total
        end
        discount = Discount.find(hash_to_check_discounts.key(hash_to_check_discounts.values.max))
        multiplier = (100 - discount.percent).to_f / 100
        grand_total +=(item.price * quantity) * multiplier
      else
        grand_total += item.price * quantity
      end
    end
    grand_total
  end

  def count_of_items
    order_items.sum(:quantity)
  end

  def cancel
    update(status: 'cancelled')
    order_items.each do |order_item|
      order_item.update(fulfilled: false)
      order_item.item.update(inventory: order_item.item.inventory + order_item.quantity)
    end
  end

  def merchant_subtotal(merchant_id)
    order_items
      .joins("JOIN items ON order_items.item_id = items.id")
      .where("items.merchant_id = #{merchant_id}")
      .sum('order_items.price * order_items.quantity')
  end

  def merchant_quantity(merchant_id)
    order_items
      .joins("JOIN items ON order_items.item_id = items.id")
      .where("items.merchant_id = #{merchant_id}")
      .sum('order_items.quantity')
  end

  def is_packaged?
    update(status: 1) if order_items.distinct.pluck(:fulfilled) == [true]
  end

  def self.by_status
    order(:status)
  end
end
