class MainController < ApplicationController

  layout 'base'

  def index

    if @show_list = !request.get?
      @linhas = BusLine.all
    else
      words = params[:q].downcase.slugfy_words.split(/\s+/)
      wild_words = words.map {|e| "%#{e}%"}
      query = words.map {|e| "?"}.join(' OR name_slug LIKE ')
      @linhas = BusLine.all(:conditions => ["name_slug LIKE #{query}"] + wild_words)
      query = words.map {|e| "?"}.join(' OR logradouro_slug LIKE ')
      query = " #{query} OR bairro_slug LIKE " + words.map {|e| "?"}.join(' OR LIKE bairro_slug ')
      @linhas.push(*BusLinePlace.all(:conditions => ["logradouro_slug LIKE #{query}"] + (wild_words * 2)).map(&:bus_line))
      @linhas = @linhas.uniq.sort {|a,b| a.code <=> b.code}
    end

  end

end
