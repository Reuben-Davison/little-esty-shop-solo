require 'rails_helper'

RSpec.describe "Discount edit page" do 
    it 'has a form to edit the discount' do
        merch1 = Merchant.create!(name: "Rob")
        discount1 = merch1.discounts.create!(threshold: 10, percentage: 25)
        visit("/merchants/#{merch1.id}/discounts/#{discount1.id}/edit")
        fill_in "threshold",	with: "99" 
        fill_in "percentage",	with: "32" 
        click_on "Update"
        expect(current_path).to eq("/merchants/#{merch1.id}/discounts/#{discount1.id}")
        expect(page).to have_content("99")
        expect(page).to have_content("32")
    end 
end