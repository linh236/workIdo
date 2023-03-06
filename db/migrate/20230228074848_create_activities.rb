class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.string :activity_type
      t.integer :perform_id
      t.json :detail

      t.timestamps
    end
    add_index :activities, :perform_id
  end
end
