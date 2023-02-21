class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.string :level
      t.references :user, null: false, foreign_key: true
      t.integer :assign_id

      t.timestamps
    end
  end
end
