class MainController < ApplicationController

  layout 'base'

  def index

    if request.post?
      @linhas = BusLine.all
    else
      @linhas = BusLine.all
    end

  end

end
