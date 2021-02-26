class AddInstructorToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :instructor, :boolean, default: false
  end
end
