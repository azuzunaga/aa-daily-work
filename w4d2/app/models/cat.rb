# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#


class Cat < ApplicationRecord
  COLORS = [
    'red',
    'orange',
    'purple',
    'blue',
    'green',
    'black',
    'white',
    'brown',
    'yellow',
    'tortoise_shell'
  ]

  validates :color, inclusion: { in: COLORS,
    message: "%{value} is not a valid color" }

  validates :sex, length: { maximum: 1 }, inclusion: { in: %w(M F),
    message: "%{value} is not a valid gender" }

  validates :birth_date, :color, :name, :sex, :description,
    presence: true

  has_many :cat_rental_requests,
    class_name: :CatRentalRequest,
    foreign_key: :cat_id,
    dependent: :destroy

  def age
    (Date.today - self.birth_date).to_i / 365
  end

end
