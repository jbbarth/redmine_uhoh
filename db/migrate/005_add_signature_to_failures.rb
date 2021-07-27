# add signature column
class AddSignatureToFailures < Rails.version < '5.1' ? ActiveRecord::Migration : ActiveRecord::Migration[4.2]
  def change
    add_column :failures, :signature, :string
  end
end
