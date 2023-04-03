ActiveAdmin.register Appointment do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :check_in, :check_out, :status, :timeslot,:number_of_pax


index do
  id_column
  column:check_in
  column:check_out
  column:status
  column:timeslot
  column:number_of_pax
  actions
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
