ActiveAdmin.register Appointment do


    menu parent: 'Booking History', label: 'Booking History'
    actions :index, :show
    
    filter :user
    filter :appointment
    
    index do
      selectable_column
      column :id
      column :user
      column :appointment
      column :status
      column :created_at
      actions
    end
    
    show do
      attributes_table do
        row :id
        row :user
        row :appointment
        row :status
        row :created_at
      end
    end
end