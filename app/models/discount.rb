class Discount < ApplicationRecord
  validates :threshold, presence: true, numericality: { greater_than: 0}
  validates :percentage, presence: true, numericality: { in: 1..100}

  belongs_to :merchant
end
