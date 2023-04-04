class CartController < ApplicationController
    before_action :require_login
    def index
        @carts = Cart.find_by(user_id:current_user.id)
        @user = User.find(current_user.id)
        @address = @user.addresses
       
    end

    def new
        @booking = Booking.new
        @appoint = Appointment.find_by(id:params[:id])
        @address = @appoint.user.addresses
    end

    
    
end
