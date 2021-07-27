# add login column
class AddLoginToFailures < Rails.version < '5.1' ? ActiveRecord::Migration : ActiveRecord::Migration[4.2]
  def change
    add_column :failures, :login, :string
  end
end
