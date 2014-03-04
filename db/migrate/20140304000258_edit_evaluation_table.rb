class EditEvaluationTable < ActiveRecord::Migration
  def change
    add_column :evaluations, :semester_id, :integer
  end
end
