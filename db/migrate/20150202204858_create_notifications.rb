class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :post, index: true
      t.references :target_user, index: true
      t.references :send_user, index: true
      
      
      t.string :message
      t.boolean :read, default: false

      t.timestamps null: false
    end
  end
end
