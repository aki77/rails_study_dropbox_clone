class UserFilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_parent_folder
  before_action :set_file, only: %i(destroy edit update)

  def new
    @file = @parent_folder.build_file
  end

  def create
    @file = @parent_folder.build_file(user_file_params)

    if @file.save
      redirect_to @file.parent, notice: 'ファイルをアップロードしました。'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @file.update(user_file_params)
      redirect_to @file.parent, notice: 'ファイル名を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @file.destroy!
    redirect_to @file.parent, notice: 'ファイルを削除しました。'
  end

  private

    def set_file
      @file = @parent_folder.children.files.find(params[:id])
    end

    def user_file_params
      params.require(:user_file).permit(:name, :file)
    end
end
