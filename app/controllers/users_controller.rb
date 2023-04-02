class UsersController < ApplicationController
  before_action :require_login, only:[:destroy]
  before_action :not_require_login, only:[:new,:create]
  # navigate to register form
  def new
    @user = User.new
  end

  # create acc and automatically login
  def create
#   render plain:params
    crud = Crud.new(User)
    @user = crud.new(user_params)
        respond_to do |format|
          if @user.save
            flash[:success]="Register successfully"
            log_in @user
            format.html {redirect_to services_path}
          else
            format.html {render :new,status: :unprocessable_entity}
          end
        end
  end

  private def user_params
    params.require(:user).permit(:full_name,:email,:password,:password_confirmation)
  end

end
