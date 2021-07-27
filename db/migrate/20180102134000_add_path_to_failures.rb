# add path column
class AddPathToFailures < Rails.version < '5.1' ? ActiveRecord::Migration : ActiveRecord::Migration[4.2]
  def change
    add_column :failures, :path, :string
  end
end
