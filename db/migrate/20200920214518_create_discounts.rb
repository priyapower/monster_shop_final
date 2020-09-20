class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.string :description
      t.integer :quantity
      t.integer :percent
      t.boolean :enable
      t.references :merchant, foreign_key: true

      t.timestamps
    end
  end
end
