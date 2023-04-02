ActiveAdmin.register AddsOn do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :description, :amount, :service_id

  form do |f|
    f.semantic_errors *f.object.attribute_names
    f.inputs do 
      f.input :name
      f.input :description
      f.input :amount
      f.input :service_id,as:"select",collection:Service.all.map{|c| [c.name,c.id]}
   end
    f.actions
  end

  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :amount, :service_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
