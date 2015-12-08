class UserFoldersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_folder, only: %i(show destroy edit update)
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
    if @folder.update(user_folder_params)
      redirect_to @folder, notice: 'フォルダ名を更新しました。'
    else
      render :edit
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

    def user_folder_params
      params.require(:user_folder).permit(:name, :parent_id)
    end
end
