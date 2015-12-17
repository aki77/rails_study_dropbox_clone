class UserFilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_parent_folder
  before_action :set_file, only: %i(destroy edit update show download copy move share preview)

  def show
  end

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
      redirect_to @file.parent, notice: 'ファイルを更新しました。'
    else
      if move_action?
        # parent_idが不正な場合はDBから読み直さないとview側で意図しない動作になる可能性がある
        @file.reload
        render :move
      else
        render :edit
      end
    end
  end

  def destroy
    @file.destroy!
    redirect_to @file.parent, notice: 'ファイルを削除しました。'
  end

  def download
    send_file @file.file.current_path, filename: @file.name
  end

  def preview
    raise Forbidden unless @file.image?
    send_file @file.file.current_path, disposition: 'inline'
  end

  def copy
    @file.copy!
    redirect_to @file.parent, notice: 'ファイルをコピーしました。'
  end

  def move
  end

  def share
    @shared_file = @file.shared_files.build
  end

  private

    def set_file
      @file = @parent_folder.children.files.find(params[:id])
    end

    def user_file_params
      if params[:action] == 'create'
        params.require(:user_file).permit(:file)
      else
        params.fetch(:user_file, {}).permit(:name, :parent_id)
      end
    end

    def move_action?
      params[:user_file].try(:has_key?, :parent_id)
    end
end
