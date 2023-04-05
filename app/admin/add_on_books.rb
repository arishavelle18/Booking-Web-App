ActiveAdmin.register AddOnBook do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :description, :amount, :booking_id


  filter :name, filters: [:contains]
  filter :description, filters: [:contains]
  filter :amount, filters: [:equals]
  filter :created_at, label: 'Created At (From)', as: :date_range, filters: [:between]
  filter :updated_at, label: 'Updated At (From)', as: :date_range, filters: [:between]


  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :amount, :booking_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
