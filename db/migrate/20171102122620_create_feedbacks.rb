class CreateFeedbacks < ActiveRecord::Migration[5.1]
  def change
    create_table :feedbacks do |t|
      t.integer :rating, null: false
      t.string :comment
      t.integer :ratable_id
      t.string :ratable_type

      t.timestamps
    end
  end
end
