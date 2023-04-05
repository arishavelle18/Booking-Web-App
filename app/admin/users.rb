ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :full_name, :email, :password,:password_confirmationn

  # insert form 
  filter :id
  filter :email
  filter :created_at
  filter :updated_at
  form do |f|
    f.semantic_errors *f.object.errors.attribute_names
    f.inputs do
      f.input :full_name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end 
    f.actions
  end

  

  #
  # or
  #
  # permit_params do
  #   permitted = [:full_name, :email, :password_digest]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
