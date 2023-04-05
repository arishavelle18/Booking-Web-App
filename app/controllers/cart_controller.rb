class CartController < ApplicationController
    before_action :require_login
    def index
        
        @carts = Cart.find_by(user_id:current_user.id)
        @appoint = @carts.appointments if !@carts.nil?
        if !params[:filter].nil? && !params[:filter].blank?
            @carts = Cart.find_by(user_id:current_user.id)
            @appoint = @carts.appointments.where(status: params[:filter])
            # render plain:@appoint
        elsif params[:filter].blank?
            @carts = Cart.find_by(user_id:current_user.id)
        end     
        @user = User.find(current_user.id)
        @address = @user.addresses
       
    end

    def new
        @booking = Booking.new
        @appoint = Appointment.find_by(id:params[:id])
        if @appoint.status == "check out" || @appoint.status == "cancel"
            flash[:danger] = "Invalid Check out"
            redirect_to cart_path
        end
        @adds_ons = AddsOn.where(service_id:@appoint.service_id) || nil
        @address = @appoint.user.addresses
        @booking.build_payment
       

    end

    def create
        # render plain:params
        # render plain:params
       
        @booking = Booking.create(book_params)
        if !params[:booking][:add_on_book][:adds_on_id].nil?
            adds_on = AddsOn.find_by(id:params[:booking][:add_on_book][:adds_on_id])
            params[:booking][:add_on_book][:name] = adds_on.name
            params[:booking][:add_on_book][:description] = adds_on.description
            params[:booking][:add_on_book][:amount] = adds_on.amount
            params[:booking][:add_on_book][:booking_id] = @booking.id
        end
        
        # add_on_book = AddOnBook.new(adds_on_params)

        # render plain:@bookin.inspect
        
        if @booking.save
            a = AddOnBook.create(name:params[:booking][:add_on_book][:name],description:params[:booking][:add_on_book][:description],amount:params[:booking][:add_on_book][:amount],booking_id:Booking.last.id) if !params[:booking][:add_on_book][:adds_on_id].empty?
            a.save if !params[:booking][:add_on_book][:adds_on_id].empty?
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
    
    def show

        @appoint = Appointment.find_by(id:params[:id])
        if @appoint
            @service = @appoint.service
            @book = Booking.find_by(appointment_id:@appoint.id)
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

    def cancel
        @cart = Appointment.find_by(id:params[:id],status:"pending")
        
        if @cart
          @cart.status = "cancel"
          @cart.save
          flash[:success] = "Cancel Service Successfuly."
          redirect_to cart_path
        else
           flash[:danger] = "Invalid Access"
            redirect_to cart_path
        end
      
      end

    private

    def book_params
    params.require(:booking).permit(:first_name,:last_name,:email,:contact_number,:address_id,:service_id,:appointment_id,payment_attributes: [:amount, :pay_method],add_on_book_attributes:[:name,:description,:amount, :booking_id])
    end

    def payment_params
        params.require(:payment).permit(:amount, :pay_method)
    end

    def adds_on_params
        params.require(:add_on_book).permit(:name,:description,:amount, :booking_id)
    end



end
