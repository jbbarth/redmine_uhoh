class AddTimestampsToFailures < ActiveRecord::Migration[4.2]
  def change
    change_table :failures do |t|
      t.timestamps
    end
  end
end
