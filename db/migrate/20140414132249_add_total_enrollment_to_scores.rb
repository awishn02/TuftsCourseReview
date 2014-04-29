class AddTotalEnrollmentToScores < ActiveRecord::Migration
  def change
    add_column :professor_scores, :total_enrollment, :integer
    add_column :course_scores, :total_enrollment, :integer
  end
end
