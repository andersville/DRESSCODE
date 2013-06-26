class CreateNoteItems < ActiveRecord::Migration
  def self.up
    create_table :note_items do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :note_items
  end
end
