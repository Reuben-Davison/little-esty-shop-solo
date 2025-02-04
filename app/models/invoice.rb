class Invoice < ApplicationRecord
  validates :status, presence: true

  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :transactions
  belongs_to :customer
  has_many :discounts, through: :merchants

  enum status: {"in_progress" => 0, "completed" => 1, "cancelled" => 2}

  def invoice_total
    total = invoice_items
      .group(:invoice_id)
      .sum("invoice_items.unit_price * invoice_items.quantity")
    total[id] / 100.0
  end

  def has_items_not_shipped
    invoice_items.where.not(status: 2).empty?
  end

  def self.oldest_first
    Invoice.order(:created_at)
  end


  def savings 
    sum = 0 
    self.invoice_items.each do |ii| 
      if ii.best_discount != nil 
        percent = ii.best_discount.percentage.to_f / 100
        sum += (ii.unit_price * ii.quantity) * percent 
      end 
    end 
    sum.to_f / 100
  end
  
  def discounted_rev 
   invoice_total - savings
  end




  def merch_savings(merch, invoice) 
    sum = 0 
    merchant = merchants.find(merch.id)
    merchant.invoice_items.where("invoice_id = ?", invoice.id).each do |ii| 
      if ii.best_discount != nil 
        percent = ii.best_discount.percentage.to_f / 100
        sum += (ii.unit_price * ii.quantity) * percent 
      end 
    end 
    sum.to_f / 100
  end

  def merch_invoice_total(merch, invoice)
    merchant = merchants.find(merch.id)
    merchant.invoice_items
    .where("invoice_id = ?", invoice.id)
    .sum("invoice_items.unit_price * invoice_items.quantity") / 100
  end

  def merch_discounted_rev(merch, invoice) 
   merch_invoice_total(merch, invoice) - merch_savings(merch, invoice)
  end

end
