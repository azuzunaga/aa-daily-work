class CreatePoll < ActiveRecord::Migration[5.1]
  def change
    create_table :polls do |t|
      t.integer :user_id
      t.string :title
    end
  end
end
