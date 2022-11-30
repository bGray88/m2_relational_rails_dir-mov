class CreateDirectors < ActiveRecord::Migration[5.2]
  def change
    create_table :directors do |d|
      d.string :hometown
      d.boolean :alive
      d.integer :age
      d.string :name

      d.timestamps
    end
  end
end
