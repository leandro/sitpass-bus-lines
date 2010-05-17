class CreateBusLines < ActiveRecord::Migration
  def self.up
    create_table :bus_lines do |t|
      t.string :code, :size => 10
      t.string :name, :size => 70
      t.timestamps

      t.index :code
      t.index :name
    end
  end

  def self.down
    drop_table :bus_lines
  end
end
