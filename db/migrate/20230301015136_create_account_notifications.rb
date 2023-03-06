class CreateAccountNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :account_notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :activity, null: false, foreign_key: true
      t.boolean :mark_read

      t.timestamps
    end
  end
end
