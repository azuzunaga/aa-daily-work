# t.text "content"
# t.integer "author_id"
# t.integer "post_id"
# t.datetime "created_at"
# t.datetime "updated_at"


class Comment < ApplicationRecord
  validates :content, :author_id, :post_id, presence: true

  belongs_to :author,
    class_name: :User,
    foreign_key: :author_id

  belongs_to :post

end
