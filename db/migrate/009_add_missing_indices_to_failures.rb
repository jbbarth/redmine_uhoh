# query performance, index acknowledged flag
class AddMissingIndicesToFailures < Rails.version < '5.1' ? ActiveRecord::Migration : ActiveRecord::Migration[4.2]
  def self.up
    add_index :failures, :acknowledged
  end

  def self.down
    remove_index :failures, :acknowledged
  end
end
