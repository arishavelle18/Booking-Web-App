class SessionsController < ApplicationController
  before_action :require_login, only:[:destroy]
  before_action :not_require_login, only:[:new,:create]
    def new
        @user = Crud.new(User).new
    end

    # create login
    def create
        @user = Crud.new(User).show("email",params[:user][:email])
        respond_to do |format|
            if @user && @user.authenticate(params[:user][:password])
                flash[:success] = "Login Successfully"
                log_in @user
                format.html{redirect_to services_path }
            else
                @user = User.new()
                flash.now[:danger] = "Invalid email or password!!!"
                format.html {render :new,status: :unprocessable_entity}
            end
        end

    end

    # destroy or logout
    def destroy
        # check if the user is logged_in then it destroy the session if true
        log_out if logged_in?
        redirect_to login_path
    end

end
