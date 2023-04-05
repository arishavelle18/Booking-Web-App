class AppointmentsController < ApplicationController
    before_action :require_login
    before_action :check_if_booked
    before_action :is_full
    before_action :is_expire
    def show
        @book = Service.find_by(id:params[:id])
        
        @appointment = Appointment.new
        if @book && !@book.slots.nil?
          @slots = @book.slots.where("date >=?", Date.current)
        end
      end

    def create
        # get the max slot 
        @max_slot = Service.where(id:params[:id])

        # render plain:@max_slot.inspect
        @appointment = Appointment.where(service_id: params[:id]).where("status = ? OR status = ?", "pending", "check out")
        if @appointment
          total_pax = @appointment.sum(:number_of_pax) + (params[:appointment][:number_of_pax]).to_i
          if total_pax > @max_slot[0].slots.sum(:slot_per_timeslot)
            flash[:warning] = "Not enough slot that suit the number of pax."
            # render plain:total_pax
            redirect_to appoint_path(params[:id])
            return
          end
        end
        
        # render plain: @total_pax

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
        checker = Appointment.where(service_id: params[:id]).where("status = ? OR status = ?", "pending", "check out")
        if checker
            appoint_count = Service.where(id:params[:id])
            # render plain:appoint_count.inspect
            if !appoint_count.nil? && checker.sum(&:number_of_pax) == appoint_count[0].slots.sum(:slot_per_timeslot)
                flash[:danger] = "Service is already Full !!!"
                redirect_to services_path
            end
        end
        
    end
    private def is_expire
      # render plain:params
      checker = Service.where(id: params[:id]).where("created_at < ?",Date.current)
      if !checker.empty?
       
          flash[:danger] = "Service is already expired !!!"
          redirect_to services_path
       
      end
      
    end



end
