class ImportBusLinesData < ActiveRecord::Migration
  def self.up
    f = File.open(File.join(Rails.root, 'db', 'data', 'bus-lines-data.txt'), 'r')

    bus_line = nil
    f.readlines.each do |line|
      line = line.unpack('C*').pack('U*')
      split = line.split('||')
      next if split.size < 2
      if split.size == 3
        BusLinePlace.create(
          :bus_line_id => bus_line.id,
          :bairro => split[1],
          :logradouro => split.first,
          :ida => split.last.to_i == 0
        )
      else
        bus_line = BusLine.create(
          :code => split.first.strip.to_i,
          :name => (name = split.last.strip)
        )
      end
    end
  end

  def self.down
    BusLine.destroy_all
    BusLinePlace.destroy_all
  end
end
