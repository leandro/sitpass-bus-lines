class MainController < ApplicationController

  layout 'base'

  def index
    @linhas = BusLine.all
  end

end
