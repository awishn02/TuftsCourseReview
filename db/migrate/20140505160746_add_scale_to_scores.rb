class AddScaleToScores < ActiveRecord::Migration
  def change
    change_column :professor_scores, :score, :decimal, :precision => 8, :scale => 2
    change_column :course_scores, :score, :decimal, :precision => 8, :scale => 2
  end
end
