class AddClosedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :closed, :boolean, default: false
  end
end
