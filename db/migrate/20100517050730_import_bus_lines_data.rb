class ImportBusLinesData < ActiveRecord::Migration
  def self.up
    f = File.open(File.join(Rails.root, 'db', 'data', 'lines-data.txt'), 'r')
    bus_lines = eval(f.read)

    bus_lines.each do |line|
      bus_line = BusLine.create(:code => line[:code], :name => line[:name])

      line[:places].each do |place|
        BusLinePlace.create(:bus_line_id => bus_line.id, :bairro => place.last, :logradouro => place.first)
      end
    end
  end

  def self.down
    BusLine.destroy_all
    BusLinePlace.destroy_all
  end
end
