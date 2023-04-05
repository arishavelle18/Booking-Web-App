ActiveAdmin.register Payment do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :amount, :method  

  filter :amount_equals, label: "Amount"
  filter :pay_method_contains, label: "Pay Method"
  filter :created_at, label: "Created At"
  # or
  #
  # permit_params do
  #   permitted = [:amount, :method]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
