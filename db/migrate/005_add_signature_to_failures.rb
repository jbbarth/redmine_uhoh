class AddSignatureToFailures < ActiveRecord::Migration[4.2]
  def change
    add_column :failures, :signature, :string
  end
end
