class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |d|
      d.string :version
      d.string :rating
      d.boolean :censored
      d.integer :length_in_mins
      d.string :name

      d.timestamps
    end
  end
end
