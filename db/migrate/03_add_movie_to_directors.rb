class AddMovieToDirectors < ActiveRecord::Migration[5.2]
  def change
    add_reference :movies, :director, foreign_key: true, null: false
  end
end
