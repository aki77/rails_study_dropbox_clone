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
      if move_action?
        # parent_idが不正な場合はDBから読み直さないとview側で意図しない動作になる可能性がある
        @folder.reload
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
      if params[:action] == 'create'
        params.require(:user_folder).permit(:name)
      else
        params.require(:user_folder).permit(:name, :parent_id)
      end
    end

    def correct_folder
      raise Forbidden if @folder.root?
    end

    def move_action?
      params[:user_folder].try(:has_key?, :parent_id)
    end
end
