class DiscountsController < ApplicationController
    def index 
        @merchant = Merchant.find(params[:merchant_id])
        @discounts = @merchant.discounts
    end 

    def new 
    end
    
    def destroy  
        Discount.destroy(params[:id])
        redirect_to "/merchants/#{params[:merchant_id]}/discounts"
    end

    def create 
        merchant = Merchant.find(params[:merchant_id])
        discount = merchant.discounts.new(discount_params)

        if discount.save
        redirect_to "/merchants/#{merchant.id}/discounts"
        else
        flash[:alert] = "Error: Please fill in fields correctly"
        redirect_to "/merchants/#{merchant.id}/discounts/new"
        end
    end   

    private 
    def discount_params 
            params.permit(:threshold, :percentage) 
    end
end
