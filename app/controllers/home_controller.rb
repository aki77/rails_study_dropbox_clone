class HomeController < ApplicationController
  before_action :guest_user!

  def index
  end

  private

    def guest_user!
      redirect_to root_folders_url if user_signed_in?
    end
end
