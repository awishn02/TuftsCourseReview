class AddTotalReviewsToProfessorscoreCoursescore < ActiveRecord::Migration
  def change
    add_column :professor_scores, :total_reviews, :integer
    add_column :course_scores, :total_reviews, :integer
  end
end
