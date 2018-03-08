# == Schema Information
#
# Table name: questions
#
#  id      :integer          not null, primary key
#  poll_id :integer
#  text    :string
#

class Question < ApplicationRecord
  validates :poll_id, presence: true

  has_many :answer_choices,
    class_name: :AnswerChoice,
    primary_key: :id,
    foreign_key: :question_id

  belongs_to :poll,
    class_name: :Poll,
    primary_key: :id,
    foreign_key: :poll_id
end
