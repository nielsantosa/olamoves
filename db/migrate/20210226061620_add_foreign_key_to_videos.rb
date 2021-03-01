class AddForeignKeyToVideos < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :videos, :users
  end
end
