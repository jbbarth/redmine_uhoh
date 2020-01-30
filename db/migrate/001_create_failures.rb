# create failures table
class CreateFailures < ActiveRecord::Migration
  def change
    # timestamps are added in a later migration, forgotten here...
    # rubocop: disable Rails/CreateTableWithTimestamps
    create_table :failures do |t|
      t.string :name
      t.text :context
      t.text :message
    end
    # rubocop: enable Rails/CreateTableWithTimestamps
  end
end
