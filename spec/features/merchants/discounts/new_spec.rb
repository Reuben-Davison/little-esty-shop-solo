require 'rails_helper'

RSpec.describe 'New discount page' do 
    it 'has a form to create a new discount' do 
        merch1 = Merchant.create!(name: "Rob")
        visit "/merchants/#{merch1.id}/discounts/new"
        
        fill_in "threshold",	with: "10" 
        fill_in "percentage",	with: "15" 
        click_button 'Create'
        expect(current_path).to eq("/merchants/#{merch1.id}/discounts")
    end
    
    it 'displayes an error message if info is incorrectly inputed' do 
        merch1 = Merchant.create!(name: "Rob")
        visit "/merchants/#{merch1.id}/discounts/new"

        fill_in "threshold",	with: "abd" 
        fill_in "percentage",	with: "101" 
        click_button 'Create'
        expect(page).to have_content('Error: Please fill in fields correctly') 
        expect(current_path).to eq("/merchants/#{merch1.id}/discounts/new")
        fill_in "threshold",	with: "14" 
        fill_in "percentage",	with: "101" 
        click_button 'Create'
        binding.pry
        expect(page).to have_content('Error: Please fill in fields correctly') 
    end
end