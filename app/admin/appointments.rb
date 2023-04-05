ActiveAdmin.register Appointment do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :check_in, :check_out, :status, :slot_id,:number_of_pax,:user_id,:service_id

  scope :all, default: true
  scope :pending, -> { Appointment.pending }
  scope :check_out, -> { Appointment.check_out }
  scope :cancel, -> { Appointment.cancel }




index do
  id_column
  column:check_in
  column:check_out
  column:status
  column:timeslot,label:"Appointment" do |appoint|
    "#{Time.parse(appoint.slot.start_time).strftime("%I:%M %p")} to #{Time.parse(appoint.slot.end_time).strftime("%H:%M:%S")}"
  end
  column:number_of_pax
  column:service_id,label:"Service" do |appoint|
    link_to appoint.service.name,admin_service_path(appoint.service_id)
end
  actions
end
show do
  attributes_table do 
    row :id
    row:check_in
    row:check_out
    row:status
    row:timeslot,label:"Appoointment" do |appoint|
      "#{Time.parse(appoint.slot.start_time).strftime("%I:%M %p")} to #{Time.parse(appoint.slot.end_time).strftime("%H:%M:%S")}"
    end
    row:service_id,label:"Service" do |appoint|
        link_to appoint.service.name,admin_service_path(appoint.service_id)
    end
    row:number_of_pax
  end
end

form do |f|
  f.semantic_errors *f.object.attribute_names
  f.inputs do 
    f.input :check_in, as:"datepicker"
    f.input :check_out, as:"datepicker"
    f.input :number_of_pax
    f.input :slot_id, as: "select", collection: Slot.all.map{ |c| ["#{Time.parse(c.start_time).strftime("%I:%M %p")} to #{Time.parse(c.end_time).strftime("%I:%M %p")} #{c.service.name}", c.id] }
    f.input :status
    f.input :user_id,as:"select",collection:User.all.map{ |c| [c.email,c.id]}
    f.input :service_id, as: "select",collection:Service.all.map{|c| [c.name,c.id]}
  end
  f.actions
end


  #
  # or
  #
  # permit_params do
  #   permitted = [:time, :date, :user_id, :cart_id, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
