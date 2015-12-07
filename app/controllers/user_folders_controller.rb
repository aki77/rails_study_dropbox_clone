class UserFoldersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_folder, only: %i(show)
  before_action :set_parent_folder, only: %i(new)

  def show
    @items = current_user.items.children(@folder)
  end

  def root
    @items = current_user.items.root
    render :show
  end

  def new
    @folder = current_user.folders.build(parent_folder: @parent_folder)
  end

  def edit
  end

  def create
    @folder = current_user.folders.build(user_folder_params)

    if @folder.save
      redirect_to root_user_folders_url, notice: 'フォルダを作成しました。'
    else
      render :new
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

    def set_parent_folder
      if params[:user_folder_id].present?
        @parent_folder = current_user.folders.find(params[:user_folder_id])
      end
    end

    def user_folder_params
      params.require(:user_folder).permit(:name, :parent_folder_id)
    end
end
