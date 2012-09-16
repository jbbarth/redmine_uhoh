class CreateFailures < ActiveRecord::Migration
  def change
    create_table :failures do |t|
      t.string :name
      t.text :context
      t.text :message
    end
  end
end
