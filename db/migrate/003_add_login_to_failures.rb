class AddLoginToFailures < ActiveRecord::Migration[4.2]
  def change
    add_column :failures, :login, :string
  end
end
