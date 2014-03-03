class AddDepCodeToDepartments < ActiveRecord::Migration
  def change
    add_column :departments, :dep_code, :string
  end
end
