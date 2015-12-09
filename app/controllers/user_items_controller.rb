class UserItemsController < ApplicationController
  before_action :authenticate_user!

  def search
    @items = @search.result
  end
end
