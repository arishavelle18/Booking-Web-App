module SessionsHelper

    def log_in(user)
        session[:user_id] = user.id
    end

    # check if the user or session is existing or not
    def current_user
        if(user_id = session["user_id"])
            @current_user ||= Crud.new(User).show("id",user_id)
        end
    end

    # check if the user is not admin
    def require_login
        unless logged_in?
          flash[:danger] = "You must be logged in to access this page !!!"
          redirect_to login_path
        end
    end

    def not_require_login
        unless !logged_in?
          flash[:danger] = "You must be logged out to access this page !!!"
          redirect_to services_path
        end
    end


    # check if you are logged in or logged out
    #  if ftrue meaning current user has a session
    def logged_in?
        !current_user.nil?
    end

    def log_out
        session.delete(:user_id)
        @current_user = nil
    end

end
