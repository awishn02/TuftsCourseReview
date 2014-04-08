class AddDepIdTo < ActiveRecord::Migration
  def change
    add_column :professor_scores, :department_id, :integer
    add_column :course_scores, :department_id, :integer
  end
end
