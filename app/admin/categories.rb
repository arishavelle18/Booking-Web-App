ActiveAdmin.register Category do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :description, :image, :admin_user_id 

  # show 
  show do
    attributes_table do
      row :id
      row :name
      row :description
      row :image, :label => "Image" do |category|
        if !category.image.nil?
          cl_image_tag(category.image,:width=>200,:crop=>"fill")
        else
          cl_image_tag("no_rpqcih",:width=>200,:crop=>"fill")
        end
      end
      row :admin_user_id,:label => "Admin User" do |category|
        if category.admin_user_id.present?
          admin_user = AdminUser.find_by(id:category.admin_user_id)
          # linkto and navigate to the adminuser show tha admin who post it
          link_to admin_user.email,admin_admin_user_path(admin_user)
        end
      end
    end
  end

  # column display the image and the admin who post it
index do
  selectable_column
      column :id
      column :name
      column :description
      column :image, :label => "Image" do |category|
        # check if the image is nil or not then upload image or template image
        if !category.image.nil?
          cl_image_tag(category.image,:width=>200,:crop=>"fill")
        else
          cl_image_tag("no_rpqcih",:width=>200,:crop=>"fill")
        end
      end
      column :admin_user_id,:label => "Admin User" do |category|
        if category.admin_user_id.present?
          admin_user = AdminUser.find_by(id:category.admin_user_id)
          # linkto and navigate to the adminuser show tha admin who post it
          link_to admin_user.email,admin_admin_user_path(admin_user)
        end
      end
      actions
end



  # create form for edit and create
  form do |f|
    f.semantic_errors *f.object.errors.attribute_names
    f.inputs do
      f.input :name
      f.input :description
      if f.object.image.present?
        f.input :image, as: :file, hint: cl_image_tag(f.object.image , :width=>200, :crop=>"fill")
      else
        f.input :image, as: :file
      end
      f.input :admin_user_id,label:"Admin User",as: :hidden,input_html:{value:current_admin_user.id}
    end
    f.actions
  end

  controller do 
    def create
      @category = Category.new(permitted_params[:category])
      # check if it is valid
      if @category.valid?
        # check if the category have image
        if !params[:category][:image].nil?
          if !params[:category][:image].content_type.start_with?('image/')
            @category.errors.add(:image, "The uploaded file is not an image.")
            render :new
            return
          end

          # upload picture in the cloudinary
          result = Cloudinary::Uploader.upload(params[:category][:image]) 
          @category.image = result["public_id"]
        end
        @category.save
        redirect_to admin_category_path(@category),notice: 'Category was successfully created.'
      else
        render:new
      end
    end

    # for adding cloudinary/image in the admin and editing info 
    def update
      @category = Category.find_by(id:params[:id])
      if !params[:category][:image].content_type.start_with?('image/') && !params[:category][:image].nil?
        @category.errors.add(:image, "The uploaded file is not an image.")
        render :edit
        return
      end
      Cloudinary::Uploader.destroy(@category.image) if !params[:category][:image].nil? && !@category.image.nil?
      if @category.update(permitted_params[:category])
        if !params[:category][:image].nil?
          # check if the image is image file
          result =  Cloudinary::Uploader.upload(params[:category][:image])
          @category.update_attribute(:image,result["public_id"])
        end
        redirect_to admin_category_path(@category), notice: 'Product was successfully updated.'
      else
        render :edit
      end
    end

    # for deleting cloudinary/image in the admin and info 
    def destroy
       @category = Category.find_by(id:params[:id])
       if @category
         Cloudinary::Uploader.destroy(@category.image) if !@category.image.nil? && @category.image != "no_rpqcih"
         @category.destroy
         redirect_to admin_categories_path, notice: 'Product was successfully Deleted.'
       else
        redirect_to admin_categories_path, notice: 'Unauthorized Access !!!'
       end
   end

  end


  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :image, :admin_user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
