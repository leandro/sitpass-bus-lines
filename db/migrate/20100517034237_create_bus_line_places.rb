class CreateBusLinePlaces < ActiveRecord::Migration
  def self.up
    create_table :bus_line_places do |t|
      t.string :bairro, :size => 40
      t.string :logradouro, :size => 35
      t.integer :order, :size => 35
      t.integer :bus_line_id
      t.boolean :ida, :null => false, :default => 1
      t.timestamps

      t.index :bairro
      t.index :logradouro
    end
  end

  def self.down
    drop_table :bus_line_places
  end
end
