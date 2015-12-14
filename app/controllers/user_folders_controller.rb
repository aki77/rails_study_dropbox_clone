class UserFoldersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_folder, only: %i(show destroy edit update move)
  before_action :set_parent_folder, only: %i(new create)

  def show
    @q = @folder.children.search(params[:q])
    @q.sorts = 'name asc' if @q.sorts.empty?
    @items = @q.result
  end

  def root
    @items = current_user.items.roots
    render :show
  end

  def new
    # @parent_folder.children.folders.build だと UserItem インスタンスが生成されてしまう
    @folder = @parent_folder.children.build(type: 'UserFolder')
  end

  def edit
  end

  def move
  end

  def create
    @folder = @parent_folder.children.build(user_folder_params.merge(type: 'UserFolder'))

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
      render :edit
    end
  end

  def destroy
    raise Forbidden if @folder.root?
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
end
