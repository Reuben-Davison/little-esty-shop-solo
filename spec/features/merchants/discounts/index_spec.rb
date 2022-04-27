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
        within "##{discount1.id}" do 
            expect(page).to have_content("#{discount1.percentage}")
            expect(page).to have_content("#{discount1.threshold}")
        end 
    end
    it "has a link to create a new discount" do
        merch1 = Merchant.create!(name: "Rob")
        visit "merchants/#{merch1.id}/discounts/"

        click_link "Create New Discount"
        expect(current_path).to eq("/merchants/#{merch1.id}/discounts/new")
    end

    it 'has a button to delete the discount' do 
        merch1 = Merchant.create!(name: "Rob")

        discount1 = merch1.discounts.create!(threshold: 10, percentage: 25)
        discount2 = merch1.discounts.create!(threshold: 5, percentage: 5)
        discount3 = merch1.discounts.create!(threshold: 5, percentage: 5)
        discount4 = merch1.discounts.create!(threshold: 5, percentage: 5)
        visit "merchants/#{merch1.id}/discounts/"
        within("##{discount1.id}") do 
            click_on("Delete")
        end 
        expect(current_path).to eq("/merchants/#{merch1.id}/discounts")
        expect(page).to_not have_content("#{discount1.id}")
        expect(page).to have_content("#{discount2.id}")
        expect(page).to have_content("#{discount3.id}")
        expect(page).to have_content("#{discount4.id}")
    end

    it "displays the upcoming holidays" do 
        merch1 = Merchant.create!(name: "Rob")
        merch1.discounts.create!(threshold: 10, percentage: 25)
        merch1.discounts.create!(threshold: 5, percentage: 5)
        merch1.discounts.create!(threshold: 5, percentage: 5)
        merch1.discounts.create!(threshold: 5, percentage: 5)
        visit "merchants/#{merch1.id}/discounts/"
        expect(page).to have_content("Upcoming Holidays")
        expect(page).to have_content("Memorial Day")
        expect(page).to have_content("Independence Day")

    end
end
