class UserEmailDefaultNotEmpty < ActiveRecord::Migration
  def up
    change_column :users, :email, :string, default: nil
  end

  def down
    change_column :users, :email, :string, default: ""
  end
end
