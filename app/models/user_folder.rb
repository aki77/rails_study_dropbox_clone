# == Schema Information
#
# Table name: user_items
#
#  id                 :integer          not null, primary key
#  name               :string           not null
#  user_id            :integer          not null
#  type               :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  file               :string
#  ancestry           :string
#  content_type       :string           default(""), not null
#  shared_files_count :integer          default(0), not null
#
# Indexes
#
#  index_user_items_on_ancestry  (ancestry)
#

class UserFolder < UserItem
  default_value_for :content_type, 'application/x-directory'

  def build_file(attrs = {})
    build_children('UserFile', attrs)
  end

  def build_folder(attrs = {})
    build_children('UserFolder', attrs)
  end

  # 自身の子フォルダには移動できない
  def moving_targets
    super.where.not(id: subtree_ids)
  end

  private

    def build_children(type, attrs)
      # children.folders.build だと UserItem インスタンスが生成されてしまう
      # UserFolder インスタンスを生成する為にはbuild時にtypeで指定する必要があるっぽい
      children.build(attrs.merge(type: type))
    end
end
