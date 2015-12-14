class HomeController < ApplicationController
  def index
    redirect_to current_user.root_folder if user_signed_in?
  end
end
