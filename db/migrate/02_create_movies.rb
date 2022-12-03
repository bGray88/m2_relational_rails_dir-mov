class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |d|
      d.string :version, null: false
      d.string :rating, null: false
      d.boolean :censored, null: false
      d.integer :length_in_mins, null: false
      d.string :name, null: false

      d.timestamps
    end
  end
end
