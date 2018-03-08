class CatRentalRequest < ApplicationRecord
  validates :status, inclusion: { in: %w(APPROVED DENIED PENDING),
    message: "%{value} is not a valid status" }

  belongs_to :cat,
    class_name: :Cat,
    foreign_key: :cat_id

  def overlapping_requests
    CatRentalRequest
      .where("cat_id = :cat_id AND
            ((:req_start_date BETWEEN start_date AND end_date OR :req_end_date BETWEEN start_date AND end_date) OR
            (start_date BETWEEN :req_start_date AND :req_end_date OR end_date BETWEEN :req_start_date AND :req_end_date)) AND
            id <> :id",
             cat_id: cat_id, req_start_date: start_date, req_end_date: end_date, id: id)
  end

  def overlapping_approved_requests
    overlapping_requests
      .where(status: 'APPROVED')
  end
end
