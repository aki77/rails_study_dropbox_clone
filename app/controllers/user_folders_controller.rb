class UserFoldersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_folder, only: %i(show destroy edit update move)
  before_action :set_parent_folder, only: %i(new create)
  before_action :correct_folder, only: %i(edit update destroy move)

  def show
    @q = @folder.children.search(params[:q])
    @q.sorts = 'name asc' if @q.sorts.empty?
    @items = @q.result
  end

  def new
    @folder = @parent_folder.build_folder
  end

  def edit
  end

  def move
  end

  def create
    @folder = @parent_folder.build_folder(user_folder_params)

    if @folder.save
      redirect_to @folder.parent, notice: 'フォルダを作成しました。'
    else
      render :new
    end
  end

  def update
    if @folder.update(user_folder_params)
      redirect_to @folder.parent, notice: 'フォルダを更新しました。'
    else
      if params.fetch(:user_folder, {})[:parent_id].present?
        render :move
      else
        render :edit
      end
    end
  end

  def destroy
    @folder.destroy!
    redirect_to @folder.parent, notice: 'フォルダを削除しました。'
  end

  private

    def set_folder
      @folder = current_user.folders.find(params[:id])
    end

    def user_folder_params
      params.require(:user_folder).permit(:name, :parent_id)
    end

    def correct_folder
      raise Forbidden if @folder.root?
    end
end
