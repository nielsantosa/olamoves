class AddIdVidtoVideos < ActiveRecord::Migration[6.0]
  def change
    add_column :videos, :id_vid, :bigint
  end
end
