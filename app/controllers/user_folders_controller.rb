class UserFoldersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_folder, only: %i(show destroy)
  before_action :set_parent_folder, only: %i(new)

  def show
    @items = @folder.children
  end

  def root
    @items = current_user.items.roots
    render :show
  end

  def new
    @folder = current_user.folders.build(parent: @parent_folder)
  end

  def edit
  end

  def create
    @folder = current_user.folders.build(user_folder_params)

    if @folder.save
      redirect_to @folder.parent, notice: 'フォルダを作成しました。'
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
    @folder.destroy!
    redirect_to url_for_folder(@folder.parent), notice: 'フォルダを削除しました。'
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
      params.require(:user_folder).permit(:name, :parent_id)
    end
end
