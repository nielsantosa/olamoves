class AddDatesAndCommentsToGoals < ActiveRecord::Migration[6.0]
  def change
    add_column :goals, :date, :date
    add_column :goals, :comment, :string
  end
end
