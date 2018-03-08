class CreateCatRentalRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :cat_rental_requests do |t|
      t.integer :cat_id, NULL: false
      t.date :start_date, NULL: false
      t.date :end_date, NULL: false
      t.string :status, default: "PENDING", NULL: false

      t.timestamps
    end
    add_index :cat_rental_requests, :cat_id
  end
end
