class AddPathToFailures < ActiveRecord::Migration[4.2]
  def change
    add_column :failures, :path, :string
  end
end
