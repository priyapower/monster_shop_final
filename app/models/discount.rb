class Discount < ApplicationRecord
  belongs_to :merchant

  validates_presence_of :description,
                        :quantity,
                        :percent

  validates_inclusion_of :enable, :in => [true, false]

  def self.enabled_discounts
    where(enable: true)
  end
end
