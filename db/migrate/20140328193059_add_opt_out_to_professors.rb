class AddOptOutToProfessors < ActiveRecord::Migration
  def change
    add_column :professors, :opt_out, :boolean, :default => FALSE
  end
end
