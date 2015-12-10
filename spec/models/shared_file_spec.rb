# == Schema Information
#
# Table name: shared_files
#
#  id             :integer          not null, primary key
#  user_item_id   :integer          not null
#  shared_user_id :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_shared_files_on_user_item_id_and_shared_user_id  (user_item_id,shared_user_id) UNIQUE
#

require 'rails_helper'

RSpec.describe SharedFile, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
