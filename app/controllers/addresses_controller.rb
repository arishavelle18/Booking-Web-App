class AddressesController < ApplicationController
    before_action :require_login
    def new 
        @address = Address.new
    end
    def create
        @address = Address.new(address_params)
    
        if @address.save
            flash[:success] = "Address Successfully Added"
            redirect_to cart_path
        else
            render :new
        end
    end

    def edit
        @address = Address.find_by(id:params[:id])
    end

    def update
        # find the user
        @address = Address.find(current_user.id)
        
        # check if the data is valid
        if @address.update(address_params)
            flash[:notice] = "Address was successfully updated."
            redirect_to cart_path   
        else
            render :edit
        end
    end

    def destroy 
        address = Address.find_by(id:params[:id])
        if address
            address.destroy
            flash[:success] = "Address is automatically deleted"
            redirect_to cart_path
        else
            flash[:warning] = "Invalid access please try again"
            redirect_to cart_path
        end

    end


    private def address_params
        params.require(:address).permit(:user_id,:street,:barangay,:city,:province,:postal_code)
    end
end
