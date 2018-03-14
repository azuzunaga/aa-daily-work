# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string
#  url        :string
#  content    :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord

  validates :title, :url, :user_id, presence: true

  belongs_to :author,
    class_name: :User,
    foreign_key: :user_id

  has_many :post_subs,
    class_name: :Postsub,
    foreign_key: :post_id,
    dependent: :destroy,
    inverse_of: :post

  has_many :subs,
    through: :post_subs

  has_many :comments

end
