class AddSlugs < ActiveRecord::Migration
  def self.up
    add_column(:bus_line_places, :bairro_slug, :string, :size => 40)
    add_column(:bus_line_places, :logradouro_slug, :string, :size => 35)
    add_column(:bus_lines, :name_slug, :string, :size => 70)

    begin
      remove_index(:bus_line_places, :bairro)
      remove_index(:bus_line_places, :logradouro)
      remove_index(:bus_lines, :name)
    rescue Exception => exc
      puts "Não existe indice a ser removido (#{exc.message})"
    end

    add_index(:bus_line_places, :bairro_slug)
    add_index(:bus_line_places, :logradouro_slug)
    add_index(:bus_lines, :name_slug)
  end

  def self.down
    add_index(:bus_line_places, :column => :bairro)
    add_index(:bus_line_places, :column => :logradouro)
    add_index(:bus_lines, :column => :name)
    remove_columns(:bus_line_places, :logradouro_slug, :bairro_slug)
    remove_column(:bus_lines, :name_slug)
  end
end
