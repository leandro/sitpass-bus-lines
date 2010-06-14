class GenerateSlugs < ActiveRecord::Migration

  def self.up
    self.add_slugs
  end

  def self.add_slugs
    count = 0
    BusLinePlace.reset_column_information
    BusLinePlace.all.each do |e|
      e.update_attributes(:bairro_slug => (e.bairro || '').slugfy_words, :logradouro_slug => (e.logradouro || '').slugfy_words)
      count += 1
    end
    puts "Atualizado #{count} registros"
  end

  def self.down
  end

end
