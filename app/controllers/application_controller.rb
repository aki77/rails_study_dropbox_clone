class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    def set_parent_folder
      @parent_folder = current_user.folders.find(params[:user_folder_id])
    end
end
