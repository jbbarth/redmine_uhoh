# query performance, index foreign keys
class IndexForeignKeysInFailures < ActiveRecord::Migration
  def change
    add_index :failures, :acknowledged_user_id
    add_index :failures, :user_id
  end
end
