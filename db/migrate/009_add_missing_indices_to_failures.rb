# query performance, index acknowledged flag
class AddMissingIndicesToFailures < ActiveRecord::Migration
  def self.up
    add_index :failures, :acknowledged
  end

  def self.down
    remove_index :failures, :acknowledged
  end
end
