class CreateProfessors < ActiveRecord::Migration
  def change
    create_table :professors do |t|
      t.string :name
      t.integer :department_id

      t.timestamps
    end
  end
end
