class UpdateColumnDefaultDiscounts < ActiveRecord::Migration[5.2]
  def change
    change_column_default :discounts, :enable, true
  end
end
