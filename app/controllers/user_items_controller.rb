class UserItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_folder, only: [:show]
  before_action :set_user_item, only: [:show, :edit, :update, :destroy]

  def show
    @items = @folder.childItems
  end

  def root
    @items = current_user.items.root
    render :show
  end

  def new
    @user_item = UserItem.new
  end

  def edit
  end

  def create
    @user_item = UserItem.new(user_item_params)

    respond_to do |format|
      if @user_item.save
        format.html { redirect_to @user_item, notice: 'User item was successfully created.' }
        format.json { render :show, status: :created, location: @user_item }
      else
        format.html { render :new }
        format.json { render json: @user_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user_item.update(user_item_params)
        format.html { redirect_to @user_item, notice: 'User item was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_item }
      else
        format.html { render :edit }
        format.json { render json: @user_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user_item.destroy
    respond_to do |format|
      format.html { redirect_to user_items_url, notice: 'User item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_folder
      @folder = current_user.folders.find(params[:id])
    end

    def set_user_item
      @user_item = UserItem.find(params[:id])
    end

    def user_item_params
      params[:user_item]
    end
end
