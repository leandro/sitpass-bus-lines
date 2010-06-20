class BusLinesController < ApplicationController

  def show
    @bus_line = BusLine.find(params[:id])
    @bus_line_places = @bus_line.bus_line_places.all(:order => 'ida')
    @places_go = @bus_line_places.select {|e| e.ida == true}
    @places_back = @bus_line_places - @places_go
  end

end
