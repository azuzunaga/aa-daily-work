# == Schema Information
#
# Table name: users
#
#  id       :integer          not null, primary key
#  username :string
#

class User < ApplicationRecord
  validates :username, uniqueness: true

  has_many :authored_polls,
    class_name: :Poll,
    primary_key: :id,
    foreign_key: :user_id

  has_many :responses,
    class_name: :Response,
    primary_key: :id,
    foreign_key: :user_id
end
