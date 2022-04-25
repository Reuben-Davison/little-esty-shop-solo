require "rails_helper"

RSpec.describe InvoiceItem do
  describe "relationships" do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
  end

  describe "validations" do
    it { should validate_numericality_of(:quantity) }
    it { should validate_numericality_of(:unit_price) }
    it { should validate_presence_of(:status) }
  end

  describe 'instance methods' do 
    it 'returns the best discount' do 
      merch = Merchant.create!(name: "Safeway")
      customer = Customer.create!(first_name: "Rob", last_name: "Danger")
      invoice = customer.invoices.create!(status:1)
      discount1 = merch.discounts.create!(threshold: 5, percentage: 20)
      discount2 = merch.discounts.create!(threshold: 10, percentage: 70)
      discount3 = merch.discounts.create!(threshold: 40, percentage: 50)
      discount4 = merch.discounts.create!(threshold: 5, percentage: 50)
      item1 = merch.items.create!(name: "abc", description: "thing", unit_price: 500)
      item2 = merch.items.create!(name: "efg", description: "other", unit_price: 2300)
      item3 = merch.items.create!(name: "hij", description: "next", unit_price: 700)
      @ii = item1.invoice_items.create!(invoice_id: invoice.id, quantity: 50, unit_price: item1.unit_price, status: 2)
      ii2 = item2.invoice_items.create!(invoice_id: invoice.id, quantity: 1, unit_price: item2.unit_price, status: 2)
      ii3 = item3.invoice_items.create!(invoice_id: invoice.id, quantity: 9, unit_price: item3.unit_price, status: 2)
      expect(@ii.best_discount).to eq(discount2)
      expect(ii2.best_discount).to eq(nil)
      expect(ii3.best_discount).to eq(discount4)
    end
  end
end
