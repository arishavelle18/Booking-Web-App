ActiveAdmin.register Slot do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :start_time,:end_time, :date,:slot_per_timeslot,:service_id


filter :id
filter :service_id, as: :select, collection: Service.all.map { |service| [service.name, service.id] }
filter :start_time, as: :string, label: "Start Time (hh:mm)"
filter :date, as: :date_range
filter :created_at, as: :date_range
filter :updated_at, as: :date_range
filter :slot_per_timeslot
filter :end_time, as: :string, label: "End Time (hh:mm)"


  show do
    attributes_table do
      row :id
      row :start_time,:sortable => :start_time do |slot|
        Time.parse(slot.start_time).strftime("%H:%M:%S") if !slot.start_time.nil?
      end
      row :end_time,:sortable => :end_time do |slot|
        Time.parse(slot.end_time).strftime("%H:%M:%S") if !slot.end_time.nil?
      end
      row :slot_per_timeslot
      row :date
      row :service_id,label:"Service" do |slot|
          link_to slot.service.name,admin_service_path(slot.service.id)
      end
    end
  end


# display index
  index do
    selectable_column
        id_column
        # .strftime("%I:%M %p") 
        column :start_time,:sortable => :start_time do |slot|
          Time.parse(slot.start_time).strftime("%I:%M %p") if !slot.start_time.nil?
        end
        # .
        column :end_time,:sortable => :end_time do |slot|
          Time.parse(slot.end_time).strftime("%I:%M %p") if !slot.end_time.nil?
        end
        column :slot_per_timeslot
        column :date
        column :service_id,label:"Service" do |slot|
            link_to slot.service.name,admin_service_path(slot.service.id)
        end
        actions
  end

  form do |f|
    f.semantic_errors *f.object.attribute_names
    f.inputs do
      f.input :date, as: :datepicker
      f.input :start_time, as: :time_picker
      f.input :end_time,as: :time_picker
      f.input :slot_per_timeslot
      f.input :service_id,as:"select",label:"Services",collection:Service.all.map{ |c| [c.name,c.id]}
    end
    f.actions
  end

  

  #
  # or
  #
  # permit_params do
  #   permitted = [:time, :date, :services_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
