class CreateEntriesTable < ActiveRecord::Migration[6.0]
    def change
      create_table :entries do |t|
        t.text :content
        t.references :user
        t.references :journal
        t.timestamps
      end 
    end
end
