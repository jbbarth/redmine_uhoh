# add signature column
class AddSignatureToFailures < ActiveRecord::Migration
  def change
    add_column :failures, :signature, :string
  end
end
