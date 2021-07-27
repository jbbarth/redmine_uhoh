# add user_id column
class AddUserIdToFailures < Rails.version < '5.1' ? ActiveRecord::Migration : ActiveRecord::Migration[4.2]
  def change
    add_column :failures, :user_id, :integer
  end
end
