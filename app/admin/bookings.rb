ActiveAdmin.register Booking do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :first_name, :last_name, :email, :contact_number,:address_id, :payment_id, :service_id,:appointment_id,:adds_on_booking_id

  filter :id
  filter :address_id, as: :select, collection: Address.all.map { |address| ["#{address.street} #{address.barangay} #{address.city} #{address.province}", address.id] }
  filter :payment_id, as: :select, collection: Payment.all.map { |payment| [ payment.pay_method, payment.id] }
  filter :service_id, as: :select, collection: Service.all.map { |service| [service.name, service.id] }
  filter :appointment_id, as: :select, collection: Appointment.all.map { |appointment| [appointment.id, appointment.id] }
  filter :first_name, as: :string, label: "First Name (Contains)"
  filter :last_name, as: :string, label: "Last Name (Contains)"
  filter :email, as: :string, label: "City (Contains)"
  filter :contact_number, as: :string, label: "Contact Number (Contains)"
  filter :created_at, label: "Created At (From)", as: :date_range
  filter :updated_at, label: "Updated At (From)", as: :date_range

  #
  # or
  #
  # permit_params do
  #   permitted = [:first_name, :last_name, :email, :contact_number, :user_id, :payment_id, :cart_id, :status, :available_date, :available_time, :services_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
