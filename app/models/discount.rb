class Discount < ApplicationRecord
  validates :threshold, presence: true, numericality: { greater_than: 0}
  validates :percentage, presence: true, numericality: { greater_than: 0, less_than: 101}

  belongs_to :merchant
end
