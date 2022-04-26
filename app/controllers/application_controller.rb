class ApplicationController < ActionController::Base
    def logged_in_user
        unless current_user.present?
          flash[:danger] = "ログインしてください。"
          redirect_to new_user_session_path
        end
    end
end
