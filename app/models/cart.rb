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
      merchant.discounts.order(:quantity).each do |discount|
        quantity = @contents[item.id.to_s]
        if discount_conditions_met?(item, quantity)
          message = "Congratulations! Your quantity meets this bulk discount"
        else
          break message = discount.description
        end
      end
    end
    message
  end

  def grand_total
    grand_total = 0.0
    @contents.each do |item_id, quantity|
      item = Item.find(item_id)
      if discount_conditions_met?(item, quantity)
        grand_total += total_after_discount(item, quantity)
      else
        grand_total += item.price * quantity
      end
    end
    grand_total
  end

  def discount_conditions_met?(item, quantity)
    if item.merchant.discounts.exists?
      item.merchant.discounts.where("#{quantity} >= quantity").exists?
    end
  end

  def total_after_discount(item, quantity)
    total = item.price * quantity
    discount = Discount.find(pull_best_discount(item, quantity))
    update_cart_with_discounts(discount, total)
  end

  def update_cart_with_discounts(discount, current_total)
    multiplier = (100 - discount.percent).to_f / 100
    updated_total = current_total * multiplier
    @saved_discounts += current_total - updated_total
    updated_total
  end

  def pull_best_discount(item, quantity)
    @saved_discounts = 0.0
    hash_for_discounted_totals = Hash.new
    item.merchant.discounts.each do |discount|
      multiplier = (100 - discount.percent).to_f / 100
      current_total = item.price * quantity
      hash_for_discounted_totals[discount.id] = current_total * multiplier
    end
    binding.pry
    hash_for_discounted_totals.key(hash_for_discounted_totals.values.max)
    # @saved_discounts += current_total - hash_for_discounted_totals[discount.id]
  end


  # BRAINSTORM FOR REFACTOR
  # - grand total can still be hit
  # - Should i put the condition in grand total or in the view?
      # - If I put it in the view, it needs to compare to something?
            # if cart.grandtotal >= cart.total_after_discounts
            #   <h3>Total: <%= number_to_currency(cart.grand_total) %></h3>
            # else
            #   <h3>Total: <%= number_to_currency(cart.total_after_discount) %></h3>
            # end

            # Looked up refactoring above == Ternary Operator (https://www.rubyguides.com/2019/10/ruby-ternary-operator/ && https://docs.ruby-lang.org/en/2.4.0/syntax/control_expressions_rdoc.html#label-Ternary+if)

            # BECOMES

            # <h3>Total: <%=cart.grandtotal >= cart.total_after_discounts ? :number_to_currency(cart.grand_total) : :number_to_currency(cart.total_after_discount)%></h3>

            # cart.grandtotal >= cart.total_after_discounts ? :cart.grand_total : :cart.total_after_discount

            # Decided to set above to the condition for CART.CORRECTED_TOTAL which is actually what is going to be called in the view :)


  # Cool - I've setup a new cart method call in the view
  # I set up the corresponding method in the cart.rb with a conditional that checks grand total versus total after discount
  # Working through total after discount
  # HATED MY CURRENT METHOD
    # Decided to go back to hitting only grand_total from view
    # Condition for boolean return (I UNDERSTAND HOW TO USE MY WHERE AND MY EXISTS? !!!!!!!)
  # Updated condition for showing discounts saved by using the discount_conditions_met? method I'm updating




      # I have access to:
          # Discount conditions met (checks if any meet quantity and returns true)
              # HOW CAN I MAKE THIS ACTIVERECORD??
              # meets quantity is a condition == .where("quantity >= discount.quantity")
              # returns true... The only AR I found that returns a boolean is .exist?
                  # Does it still need to be a boolean? If I call the record that meets the quantity
                  # How do I limit it so it also meets the discount
                      # Can I use a proc to return a hash with the discounted prices?
                      # If I am able to use .where to check condition AND then use.... .sum? but I still want to call .limit?
                      # Hmmm....
                      # Let's first start with removing the discount conditions by using a .where!
          # All possible discounts (checks all qualifying discount prices and returns the correct discount)
              # HOW CAN I MAKE THIS ACTIVERECORD??
          # Update Cart with Discount (does the math behind a discount and returns discounted total for that item/quantity in the cart)
              # HOW CAN I MAKE THIS ACTIVERECORD??
  #
  #
  # def grand_total
  #   @saved_discounts = 0.0
  #   grand_total = 0.0
  #   @contents.each do |item_id, quantity|
  #     item = Item.find(item_id)
  #     merchant = Merchant.find(item.merchant_id)
  #     if !merchant.discounts.empty? && discount_conditions_met?(item, quantity)
  #       discounted_item_total = item.price * quantity
  #       grand_total += update_cart_with_discounts(@current_discount, discounted_item_total)
  #     else
  #       grand_total += item.price * quantity
  #     end
  #   end
  #   grand_total
  # end

  # def discount_conditions_met?(item, quantity)
  #   merchant = Merchant.find(item.merchant_id)
  #   merchant.discounts.order(:quantity).each do |discount|
  #     if quantity >= discount.quantity
  #       all_possible_discounts(item, quantity)
  #       return true
  #     else
  #       return false
  #     end
  #   end
  # end

  # def all_possible_discounts(item, quantity)
  #   merchant = Merchant.find(item.merchant_id)
  #   hash_for_discounted_totals = Hash.new
  #   merchant.discounts.order(:quantity).each do |discount|
  #     if quantity >= discount.quantity
  #       multiplier = (100 - discount.percent).to_f / 100
  #       current_total = item.price * quantity
  #       discounted_total = current_total * multiplier
  #       hash_for_discounted_totals[discount.id] = current_total - discounted_total
  #     end
  #   end
  #   discount = Discount.find(hash_for_discounted_totals.key(hash_for_discounted_totals.values.max))
  #   @current_discount = discount
  # end


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
