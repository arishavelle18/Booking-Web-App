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
        @booking.build_payment

    end

    def create
        @booking = Booking.new(book_params)
        
        
        if @booking.save
            flash[:success] = "Successfully Check out"
            appoint = Appointment.find(@booking.appointment_id)
            appoint.status = "check out"
            appoint.save
            redirect_to services_path
        else
            @appoint = Appointment.find_by(id:params[:id])
            @address = @appoint.user.addresses
            render :new
        end
        
    end
    
    def destroy
        appoint = Appointment.find_by(id:params[:id])

        if appoint
            appoint.destroy
            flash[:success] = "Appointment is Successfuly Deleted."
            redirect_to cart_path
        else
            flash[:success] = "Invalid Access"
            redirect_to cart_path
        end

    end


    private

    def book_params
    params.require(:booking).permit(:first_name,:last_name,:email,:contact_number,:address_id,:service_id,:appointment_id,payment_attributes: [:amount, :pay_method])
    end

    def payment_params
        params.require(:payment).permit(:amount, :pay_method)
    end
end
