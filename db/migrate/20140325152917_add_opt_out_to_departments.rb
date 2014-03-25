class AddOptOutToDepartments < ActiveRecord::Migration
  def change
    add_column :departments, :opt_out, :boolean, :default => TRUE
  end
end
