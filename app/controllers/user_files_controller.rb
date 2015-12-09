class UserFilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_file, only: %i(destroy)
  before_action :set_parent_folder, only: %i(new create)

  def new
    @file = current_user.files.build(parent: @parent_folder)
  end

  def create
    @file = current_user.files.build(user_file_params)

    if @file.save
      redirect_to @file.parent, notice: 'ファイルをアップロードしました。'
    else
      render :new
    end
  end

  def destroy
    @file.destroy!
    redirect_to @file.parent, notice: 'ファイルを削除しました。'
  end

  private

    def set_file
      @file = current_user.files.find(params[:id])
    end

    def user_file_params
      params.require(:user_file).permit(:file, :parent_id)
    end
end
