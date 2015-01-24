class UserHasManyPosts < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.belongs_to :user, index:true
    end

    change_table :users do |t|
      t.integer :posts_count, default: 0
    end
  end
end
