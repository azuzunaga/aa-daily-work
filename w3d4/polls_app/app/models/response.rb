# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  question_id      :integer
#  answer_choice_id :integer
#

class Response < ApplicationRecord

  validates :user_id, :question_id, :answer_choice_id, presence: true

  belongs_to :answer_choice,
    class_name: :AnswerChoice,
    primary_key: :id,
    foreign_key: :answer_choice_id

  belongs_to :respondent,
    class_name: :User,
    primary_key: :id,
    foreign_key: :user_id

  has_one :question,
    through: :answer_choice,
    source: :question

  has_many :responses,
    through: :respondent,
    source: :responses

  def sibling_responses

  end
end
