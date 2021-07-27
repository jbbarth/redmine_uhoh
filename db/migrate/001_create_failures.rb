# create failures table
class CreateFailures < Rails.version < '5.1' ? ActiveRecord::Migration : ActiveRecord::Migration[4.2]
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
