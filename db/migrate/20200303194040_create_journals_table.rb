class CreateJournalsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :journals do |t|
      t.string :name
    end
  end
end
