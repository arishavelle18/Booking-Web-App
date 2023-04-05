# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end
    columns do
      column do
        panel "Total Registrations" do
          div class: "blank_slate_container" do
            span class: "blank_slate" do
              span "Total Registrations:"
              span User.all.count
            end
          end
        end
      end
      # Add other dashboard sections here
    end
    columns do
      column do
        panel "Total Books" do
          div class: "blank_slate_container" do
            span class: "blank_slate" do
              span "Total Booking:"
              span Booking.all.count
            end
          end
        end
      end

      # Add other dashboard sections here
    end
    section "Most Booked Services" do
    table_for Service.joins(:appointment)
      .where(appointments: { status: ['check out', 'pending'] })
      .group("services.id")
      .order("count(appointments.id) DESC")
      .limit(2) do
        column("Service") { |service| service.name }
        column("Number of Appointments") { |service| Appointment.where(service_id:service.id,status: ['pending', 'check out']).sum(:number_of_pax) }
      end
  end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
