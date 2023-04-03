class CartController < ApplicationController
    
    def index
        @carts = Cart.find_by(user_id:current_user.id)
        @user = User.find(current_user.id)
       
    end

    def new
        @booking = Booking.new
        @appoint = Appointment.find_by(id:params[:id])
    end

    def add_address
        user = Address.new(address_params)
        # render plain:params
        if user.save
            flash[:success] = "Address Successfully Added"
            redirect_to cart_path
        else
            render :index
        end
    end

    private def address_params
        params.require(:user).permit(:user_id,:street,:barangay,:city,:province,:postal_code)
    end
    
end
