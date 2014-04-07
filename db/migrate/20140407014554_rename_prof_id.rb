class RenameProfId < ActiveRecord::Migration
  def change
    rename_column :professor_scores, :prof_id, :professor_id
    rename_column :course_scores, :prof_id, :professor_id
  end
end
