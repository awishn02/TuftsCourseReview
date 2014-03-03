class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :evaluations, :teacher_id, :professor_id
  end
end
