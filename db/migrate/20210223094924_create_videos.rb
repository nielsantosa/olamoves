class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.integer :price
      t.integer :difficulty
      t.integer :duration

      t.timestamps
    end
  end
end
