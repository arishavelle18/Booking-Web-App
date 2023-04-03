class AppointmentsController < ApplicationController
    before_action :check_if_booked
    before_action :is_full
    def show
        @book = Service.find_by(id:params[:id])
        
        @appointment = Appointment.new
        if @book && !@book.slots.nil?
          @slots = @book.slots.where("date >=?", Date.current)
        end
      end

    def create
        @cart = Cart.find_or_create_by(user_id: current_user.id)
        params[:appointment][:cart_id] = @cart.id

        @appointment = Appointment.new(appoint_params)

        if @appointment.save
            flash[:success] = "Appointment Successfully"
            redirect_to services_path
        else
            @book = Service.find_by(id:params[:id])
              if @book && !@book.slots.nil?
                @slots = @book.slots.where("date >=?", Date.current)
              end
            render :show
        end
    end

    private 
    def appoint_params
      params.require(:appointment).permit(:check_in,:check_out,:slot_id,:status,:number_of_pax,:user_id,:cart_id,:service_id)
    end
    # check if the user is already book
    private def check_if_booked
        checker = Appointment.find_by(user_id:current_user.id,service_id:params[:id])
        if checker
            flash[:danger] = "You're already booked in this service!!!"
            redirect_to services_path
        end
    end
    
    # check if the services is full
    private def is_full
        checker = Appointment.where(service_id: params[:id])
        if checker
            appoint_count = Appointment.find_by(service_id:params[:id])
    
            if !appoint_count.nil? && checker.count == appoint_count.slot.slot_per_timeslot
                flash[:danger] = "Service is already Full !!!"
                redirect_to services_path
            end
        end
        
    end




end
