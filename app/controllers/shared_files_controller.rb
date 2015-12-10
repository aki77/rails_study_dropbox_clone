class SharedFilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_parent_folder
  before_action :set_file
  before_action :set_shared_file, only: %i(show destroy)

  def show
  end

  def create
    @shared_file = @file.shared_files.build(shared_file_params)

    if @shared_file.save
      redirect_to share_user_folder_user_file_path(@file.parent, @file), notice: 'ファイルを共有しました。'
    else
      render 'user_files/share'
    end
  end

  def destroy
    @shared_file.destroy!
    redirect_to share_user_folder_user_file_path(@file.parent, @file), notice: 'ファイルの共有を解除しました。'
  end

  private

    def set_file
      @file = @parent_folder.children.files.find(params[:user_file_id])
    end

    def set_shared_file
      @shared_file = @file.shared_files.find(params[:id])
    end

    def shared_file_params
      params.require(:shared_file).permit(:email)
    end
end
