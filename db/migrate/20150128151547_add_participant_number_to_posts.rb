class AddParticipantNumberToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :max_participant_number, :integer, default: 2
  end
end
