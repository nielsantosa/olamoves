class CreateGoals < ActiveRecord::Migration[6.0]
  def change
    create_table :goals do |t|
      t.string :description
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
