class AddHttpMethodToFailures < ActiveRecord::Migration[6.1]
  def change
    add_column :failures, :http_method, :string, limit: 10
  end
end
