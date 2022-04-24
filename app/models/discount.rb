class Discount < ApplicationRecord
  validates :threshold, presence: true, numericality: true
  validates :percentage, presence: true, numericality: { in: 1..100}

  belongs_to :merchant


  enum status: { "disabled" => 0, "enabled" => 1}

  def to_dollars
    unit_price.to_f / 100
  end

  def top_date_sales
 invoices.select("invoices.created_at, sum(invoice_items.quantity * invoice_items.unit_price) as total_rev")
      .group("invoices.created_at")
      .order("total_rev")
      .first
      .created_at  
  end
end
