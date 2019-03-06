class AddGenreToShow < ActiveRecord::Migration[5.1]
  def change
    add_column :shows, :genre, :string
  end
end