class ServicesController < ApplicationController
    before_action :require_login
    def index
        @services = Service.all.order(created_at: :desc)
    end
end
