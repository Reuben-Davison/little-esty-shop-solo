class InvoiceItem < ApplicationRecord
  validates :item_id, presence: true
  validates :invoice_id, presence: true
  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
  validates :status, presence: true, numericality: true

  belongs_to :item
  belongs_to :invoice

  has_one :merchant, through: :item
  has_many :discounts, through: :merchant

  enum status: {"pending" => 0, "packaged" => 1, "shipped" => 2}

  def best_discount 
    quantity = self.quantity
    discounts.where("discounts.threshold <= ?", quantity)
    .order("discounts.percentage")
    .last
  end
  

end
