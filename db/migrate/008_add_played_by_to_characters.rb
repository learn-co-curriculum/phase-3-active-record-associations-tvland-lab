class AddPlayedByToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :played_by, :string
  end
end