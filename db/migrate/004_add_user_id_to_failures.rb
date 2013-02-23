class AddUserIdToFailures < ActiveRecord::Migration
  def change
    add_column :failures, :user_id, :integer
  end
end
