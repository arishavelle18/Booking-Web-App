ActiveAdmin.register Location do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :street, :barangay, :city, :province, :postal_code
  
  form do |f|
    f.semantic_errors *f.object.attribute_names
    f.inputs do
      f.input :street
      f.input :barangay
      f.input :city
      f.input :province
      f.input :postal_code
    end
    f.actions
  end


  # or
  #
  # permit_params do
  #   permitted = [:street, :barangay, :city, :province, :postal_code]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
