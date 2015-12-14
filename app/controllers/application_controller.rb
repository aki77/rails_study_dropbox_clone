class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  class Forbidden < ActionController::ActionControllerError; end

  before_filter :set_global_search_variable, if: :user_signed_in?

  private

    def set_parent_folder
      @parent_folder = current_user.folders.find(params[:user_folder_id])
    end

    def set_global_search_variable
      @search = current_user.items.search(params[:search])
    end
end
