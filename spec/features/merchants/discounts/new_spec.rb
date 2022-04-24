require 'rails_helper'

RSpec.describe 'New discount page' do 
    it 'has a form to create a new discount' do 
        merch1 = Merchant.create!(name: "Rob")
        visit "/merchants/#{merch1.id}/discounts/new"

        fill_in "threshold",	with: "10" 
        fill_in "percentage",	with: "15" 
        click_button 'Create'
        expect(current_path).to eq("/merchants/#{merch1.id}/discounts")
        save_and_open_page
    end
end