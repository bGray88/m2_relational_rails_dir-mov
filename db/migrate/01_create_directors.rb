class CreateDirectors < ActiveRecord::Migration[5.2]
  def change
    create_table :directors do |d|
      d.string :hometown, null: false
      d.boolean :alive, null: false
      d.integer :age, null: false
      d.string :name, null: false

      d.timestamps
    end
  end
end
