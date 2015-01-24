class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :post, index: true
      t.references :user, index: true
      t.text :content
      t.timestamps null: false
    end

    add_column :posts, :comments_count, :integer, default: 0
    add_column :users, :comments_count, :integer, default: 0
  end
end