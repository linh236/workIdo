class CreateActiveProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :active_projects do |t|
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
