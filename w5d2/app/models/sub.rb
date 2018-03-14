# == Schema Information
#
# Table name: subs
#
#  id          :integer          not null, primary key
#  title       :string
#  description :string
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Sub < ApplicationRecord

  validates :title, :user_id, presence: true

  belongs_to :moderator,
    class_name: :User,
    foreign_key: :user_id

  has_many :post_subs,
    class_name: :Postsub,
    dependent: :destroy,
    inverse_of: :sub,
    foreign_key: :sub_id

  has_many :posts,
    through: :post_subs

end
