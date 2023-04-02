class ServicesController < ApplicationController
    before_action :require_login
    def index
        @services = Crud.new(Service).index
    end
end
