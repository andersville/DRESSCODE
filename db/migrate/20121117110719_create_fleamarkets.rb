class CreateFleamarkets < ActiveRecord::Migration
  def self.up
    create_table :fleamarkets do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :fleamarkets
  end
end
