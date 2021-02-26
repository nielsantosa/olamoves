class CreateWorkouts < ActiveRecord::Migration[6.0]
  def change
    create_table :workouts do |t|
      t.date :date
      t.references :user

      t.timestamps
    end
  end
end
