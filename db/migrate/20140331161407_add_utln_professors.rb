class AddUtlnProfessors < ActiveRecord::Migration
  def change
    add_column :professors, :utln, :string
  end
end
