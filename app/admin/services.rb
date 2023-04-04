ActiveAdmin.register Service do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :service_details, :image, :price, :admin_user_id, :category_id, :location_id


index do
  selectable_column
  id_column
  column :name
  column :price
  column :service_details
  column :image, :label => "Image" do |service|
    # check if the service email has image or not
    if !service.image.nil?
      cl_image_tag(service.image,:width=>200,:crop => "fill")
    else
      cl_image_tag(no_rpqcih,:width=>200,:crop => "fill")
    end
  end
  column :available_time,"Time" do |service|
    if !service.slots.empty?
      slots = service.slots.map{|c| ["#{c.start_time} to #{c.end_time}"]}
      select_tag "booking[slot_id]", options_for_select(slots), class: "form-control"
    else
      "No time has been set,Please set to Slot Section"
    end
  end
  column :available_date,"Date" do |service|
    if !service.slots.empty?
      date = service.slots.map{|c| ["#{c.date}"]}
      select_tag "booking[slot_id]", options_for_select(date), class: "form-control"

    else
      "No time has been set,Please set to Slot Section"
    end
  end
  column :optional_adds_on,"Adds_on" do |service|
    # check if the service offer adds_on or not
    if !service.adds_ons.empty?
      adds_on = service.adds_ons.map { |c| [c.name, c.id] }
      select_tag "booking[adds_on]", options_for_select(adds_on), class: "form-control"
    else
      "No Adds_On Available"
    end
    
  end
  actions
end


# show
show do
  attributes_table do 
    row :id
    row :name
    row :service_details
    row :image, :label => "Image" do |service|
      # check if the service email has image or not
      if !service.image.nil?
        cl_image_tag(service.image,:width=>200,:crop => "fill")
      else
        cl_image_tag(no_rpqcih,:width=>200,:crop => "fill")
      end
    end
    row :price
    # display the name of the admin 
    row :admin_user_id,:label => "Admin User" do |service|
      if service.admin_user_id.present?
        admin_user = AdminUser.find_by(id:service.admin_user_id)
        link_to admin_user.email,admin_admin_user_path(admin_user)
      end
    end
    # display the valuie of the category_id
    row :category_id,:label => "Category" do |service|
      link_to service.category.name,admin_category_path(service.category.id)
    end
    row :location_id,:label => "Location" do |service|
      place = service.location
      link_to "#{place.street} #{place.barangay} #{place.city} #{place.province} Postal Code: #{place.postal_code}", admin_location_path(place.id)
    end
    row :available_time,"Time" do |service|
      if !service.slots.empty?
        slots = service.slots.map{|c| ["#{c.start_time} to #{c.end_time}"]}
        select_tag "booking[slot_id]", options_for_select(slots), class: "form-control"
      else
        "No time has been set,Please set to Slot Section"
      end
    end
    row :available_date,"Date" do |service|
      if !service.slots.empty?
        date = service.slots.map{|c| ["#{c.date}"]}
        select_tag "booking[slot_id]", options_for_select(date), class: "form-control"
  
      else
        "No time has been set,Please set to Slot Section"
      end
    end
  end
end



  form do |f|
    f.semantic_errors *f.object.attribute_names
    f.inputs do 
      f.input :name
      f.input :service_details
      if f.object.image.present?
        f.input :image, as: :file, hint: cl_image_tag(f.object.image , :width=>200, :crop=>"fill")
      else
        f.input :image, as: :file
      end
      f.input :price
      f.input :admin_user_id,:label => "Admin User",as:"hidden",input_html:{value:current_admin_user.id}
      f.input :category_id, as: "select",collection:Category.all.map{ |c| [c.name,c.id]}
      f.input :location_id,as:"select",collection:Location.all.map{ |c| ["#{c.street} #{c.barangay} #{c.city} #{c.province} Postal Code: #{c.postal_code}",c.id]}
    end
    f.actions
  end

  controller do
    def create
      @service = Service.new(permitted_params[:service])
      # check if it is valid
      if @service.valid?
        # check if the service have image
        if !params[:service][:image].nil?
          if !params[:service][:image].content_type.start_with?('image/')
            @service.errors.add(:image, "The uploaded file is not an image.")
            render :new
            return
          end

          # upload picture in the cloudinary
          result = Cloudinary::Uploader.upload(params[:service][:image]) 
          @service.image = result["public_id"]
        end
        @service.save
        redirect_to admin_service_path(@service),notice: 'Services was successfully created.'
      else
        render:new
      end
    end

     # for adding cloudinary/image in the admin and editing info 
     def update
      @service = Service.find_by(id:params[:id])
      if params[:service][:image].present? && !params[:service][:image].content_type.start_with?('image/')
        @service.errors.add(:image, "The uploaded file is not an image.")
        render :edit
        return
      end
      Cloudinary::Uploader.destroy(@service.image) if params[:service][:image]
      if @service.update(permitted_params[:service])
        if !params[:service][:image].nil?
          # check if the image is image file
          result =  Cloudinary::Uploader.upload(params[:service][:image])
          @service.update_attribute(:image,result["public_id"])
        end
        redirect_to admin_service_path(@service), notice: 'Product was successfully updated.'
      else
        render :edit
      end
    end
  end

  #
  # or
  #
  # permit_params do
  #   permitted = [:service_details, :image, :price, :admin_user_id, :category_id, :location_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
