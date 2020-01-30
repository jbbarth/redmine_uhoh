# add path column
class AddPathToFailures < ActiveRecord::Migration
  def change
    add_column :failures, :path, :string
  end
end
