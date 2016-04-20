class AddGifFileToGifs < ActiveRecord::Migration
  def change
    add_column :gifs, :gif_file_id, :string
  end
end
