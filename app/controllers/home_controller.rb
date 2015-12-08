class HomeController < ApplicationController
  before_action :guest_user!

  def index
  end

  private

    def guest_user!
      redirect_to current_user.root_folder if user_signed_in?
    end
end
