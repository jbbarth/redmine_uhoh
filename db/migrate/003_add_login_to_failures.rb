# add login column
class AddLoginToFailures < ActiveRecord::Migration
  def change
    add_column :failures, :login, :string
  end
end
