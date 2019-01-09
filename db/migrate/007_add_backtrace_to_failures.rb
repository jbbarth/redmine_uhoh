class AddBacktraceToFailures < ActiveRecord::Migration[4.2]
  def change
    add_column :failures, :backtrace, :text
  end
end
