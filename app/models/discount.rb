class Discount < ApplicationRecord
  belongs_to :merchant

  validates_presence_of :description,
                        :quantity,
                        :percent,
                        :enabled

  # def self.enabled_discounts
  #   where(enabled: true)
  # end
end
