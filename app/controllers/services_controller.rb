class ServicesController < ApplicationController
    before_action :require_login
    def index
        @services = Service.all.order(created_at: :desc).where("created_at >= ?",Date.current)
        if @services
            @category = @services[0].category
        end
    end
end
