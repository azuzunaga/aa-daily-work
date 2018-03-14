# == Schema Information
#
# Table name: postsubs
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  sub_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Postsub < ApplicationRecord
  validates :sub_id, uniqueness: { scope: :post_id }

  belongs_to :post
  belongs_to :sub

end
