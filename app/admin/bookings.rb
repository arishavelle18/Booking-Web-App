ActiveAdmin.register Booking do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :first_name, :last_name, :email, :contact_number,:address_id, :payment_id, :service_id,:appointment_id,:adds_on_booking_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:first_name, :last_name, :email, :contact_number, :user_id, :payment_id, :cart_id, :status, :available_date, :available_time, :services_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
