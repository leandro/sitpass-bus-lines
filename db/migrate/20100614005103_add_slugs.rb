class AddSlugs < ActiveRecord::Migration
  def self.up
    add_column(:bus_line_places, :bairro_slug, :string, :size => 40)
    add_column(:bus_line_places, :logradouro_slug, :string, :size => 35)

#    remove_index(:bus_line_places, :bairro)
#    remove_index(:bus_line_places, :logradouro)

    add_index(:bus_line_places, :bairro_slug)
    add_index(:bus_line_places, :logradouro_slug)
  end

  def self.down
    add_index(:bus_line_places, :column => :bairro)
    add_index(:bus_line_places, :column => :logradouro)
    remove_columns(:bus_line_places, :logradouro_slug, :bairro_slug)
  end
end
