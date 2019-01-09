class IndexForeignKeysInFailures < ActiveRecord::Migration[4.2]
  def change
    add_index :failures, :acknowledged_user_id
    add_index :failures, :user_id
  end
end
