class MainController < ApplicationController

  layout 'base'

  def index

    terms = params[:q].to_s

    if @show_list = terms.empty?
      @lines = BusLine.all
    else
      words = terms.downcase.slugfy_words.split(/\s+/)
      wildcard_words = words.map {|e| "%#{e}%"}
      query = words.map {|e| "?"}.join(' AND name_slug LIKE ')
      @lines = BusLine.all(:conditions => ["name_slug LIKE #{query}"] + wildcard_words)
      query = words.map {|e| "?"}.join(' OR logradouro_slug LIKE ')
      query = " #{query} OR bairro_slug LIKE " + words.map {|e| "?"}.join(' OR bairro_slug LIKE ')
      places = BusLinePlace.all(:conditions => ["logradouro_slug LIKE #{query}"] + (wildcard_words * 2), :order => 'bus_line_id')
      grouped_places = {}

      while places.any?
        place = places.shift
        (grouped_places[place.bus_line_id] ||= []) << place
      end

      @matched_lines = []
      if words.size > 1

        for bus_line_id in grouped_places.keys
          all_places_in_one = grouped_places[bus_line_id].map {|e| [e.logradouro_slug, e.bairro_slug]}.flatten.join(' ')
          matched = 0
          for word in words
            matched += 1 if all_places_in_one =~ /#{word}/
          end
          @matched_lines << grouped_places[bus_line_id].first.bus_line if matched == words.size
        end

      else
        @matched_lines = BusLine.find(grouped_places.keys)
      end

      @lines.push(*@matched_lines)
      @lines = @lines.uniq.sort {|a,b| a.code <=> b.code}
    end

  end

end
