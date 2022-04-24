require "rails_helper"

RSpec.describe "Discounts index page" do 
    it  "displays all discounts related to merchant" do 
        merch1 = Merchant.create!(name: "Rob")
        merch2 = Merchant.create!(name: "Walmart")

        discount1 = merch1.discounts.create!(threshold: 10, percentage: 25)
        discount2 = merch2.discounts.create!(threshold: 5, percentage: 5)
        discount3 = merch1.discounts.create!(threshold: 5, percentage: 5)
        discount4 = merch1.discounts.create!(threshold: 5, percentage: 5)
        visit "merchants/#{merch1.id}/discounts/"
        
        expect(page).to have_content("#{discount1.id}")
        expect(page).to have_content("#{discount4.id}")
        expect(page).to have_content("#{discount3.id}")
        expect(page).to_not have_content("#{discount2.id}")
        save_and_open_page
        within "##{discount1.id}" do 
            expect(page).to have_content("#{discount1.percentage}")
            expect(page).to have_content("#{discount1.threshold}")
        end 
    end
end
