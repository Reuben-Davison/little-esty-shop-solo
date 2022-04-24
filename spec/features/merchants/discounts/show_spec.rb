require 'rails_helper'

RSpec.describe "Discount show page" do 
    it 'list discounts threshold and percentage' do 
        merch1 = Merchant.create!(name: "Rob")
        discount1 = merch1.discounts.create!(threshold: 10, percentage: 25)
        visit "merchants/#{merch1.id}/discounts/#{discount1.id}"
        expect(page).to have_content("Threshold: 10")
        expect(page).to have_content("Percentage: 25")
    end
end