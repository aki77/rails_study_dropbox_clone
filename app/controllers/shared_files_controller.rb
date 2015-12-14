class SharedFilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_parent_folder, only: %i(create)
  before_action :set_file, only: %i(create)
  before_action :set_shared_file, only: %i(show download destroy preview)
  before_action :correct_shared_user, only: %i(show download preview)
  before_action :correct_item_user, only: %i(destroy)

  def show
  end

  def download
    send_file @shared_file.file.file.current_path, filename: @shared_file.file.name
  end

  def create
    @shared_file = @file.shared_files.build(shared_file_params)

    if @shared_file.save
      # @shared_file.message はDBに保存されないので deliver_later で送信すると nil になる
      SharedMailer.shared_email(@shared_file, @shared_file.message).deliver_later
      redirect_to share_user_folder_user_file_path(@file.parent, @file), notice: 'ファイルを共有しました。'
    else
      render 'user_files/share'
    end
  end

  def destroy
    @shared_file.destroy!
    redirect_to share_user_folder_user_file_path(@shared_file.file.parent, @shared_file.file), notice: 'ファイルの共有を解除しました。'
  end

  def preview
    raise Forbidden unless @shared_file.file.image?
    send_file @shared_file.file.file.current_path, disposition: 'inline'
  end

  private

    def set_file
      @file = @parent_folder.children.files.find(params[:user_file_id])
    end

    def set_shared_file
      @shared_file = SharedFile.find(params[:id])
    end

    def correct_shared_user
      raise Forbidden unless @shared_file.shared_user == current_user
    end

    def correct_item_user
      raise Forbidden unless @shared_file.file.user == current_user
    end

    def shared_file_params
      params.require(:shared_file).permit(:email, :message)
    end
end
