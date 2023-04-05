class BookingsController < ApplicationController
  before_action :require_login
  def show
    @book = Service.find_by(id:params[:id])
    @appointment = Appointment.new
    if @book && !@book.slots.nil?
      @slots = @book.slots.where("date >=?", Date.current)
      # render html:@slots.inspect
    end
  end

  def create

    # get the service id
    date = Date.parse(params[:appointment][:date])
    time = params[:appointment][:time]
    service = Service.find(params[:appointment][:service_id]).slots.where(date:date)
  
    # check service is found
    if service
      # time = time # replace with your time value
      time_str = time
      time_obj = Time.strptime(time_str, "%H:%M")
      rounded_time = Time.new(time_obj.year, time_obj.month, time_obj.day, time_obj.hour, (time_obj.min / 30.0).ceil * 30)
      rounded_time.strftime("%H:%M")
      time = Time.zone.local(service[0].start_time.year, service[0].start_time.month, service[0].start_time.day, service[0].start_time.hour, service[0].start_time.min, service[0].start_time.sec)
      start_time = DateTime.new(2000, 1, 1, time.hour, time.min, time.sec) 
      time2 = Time.zone.local(service[0].end_time.year, service[0].end_time.month, service[0].end_time.day, service[0].end_time.hour, service[0].end_time.min, service[0].end_time.sec) 
      end_time = DateTime.new(2000, 1, 1, time2.hour, time2.min, time2.sec) 

      
      karl =[]
      # loop check if the time and slots is available
      Slot.generate_timeslots(start_time,end_time,service[0].interval).each do |slot|
        if rounded_time.strftime("%H:%M") == slot.strftime("%H:%M")
          # karl.push("hello")
          # Service.slot_per_timeslot != 
          appoint = Appointment.find_by(timeslot:DateTime.new(date.year,date.month,date.day,rounded_time.hour,rounded_time.min,rounded_time.sec)) 
          if appoint
           
          else
              # karl.push(["mali sa labas ng appoint"])
              params[:appointment][:timeslot]= DateTime.new(date.year,date.month,date.day,rounded_time.hour,rounded_time.min,rounded_time.sec) 
          end
        end
      end
      # render html:karl.inspect
    end
    
    # check if the date is existing in the appointment and if existing check if slot is available
    @cart = Cart.find_or_create_by(user_id: current_user.id)
    params[:appointment][:cart_id] = @cart.id
    @appointment = Appointment.new(appoint_params)
    render plain:@appointment.timeslot.inspect
    # if @appointment.valid?
    #   # Success
    # else
    #   @book = Service.find_by(id:params[:id])
    #   if @book && !@book.slots.nil?
    #     @slots = @book.slots.where("date >=?", Date.current)
    #   end
    #   render :show
    # end
  end



  private 
  def appoint_params
    params.require(:appointment).permit(:time,:date,:timeslot,:status,:user_id,:cart_id,:service_id)
  end
end
