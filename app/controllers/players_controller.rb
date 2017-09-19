class PlayersController < ApplicationController

  def create
    @player = Player.new(name: params[:name], championship_id: params[:championship_id])
    unless @player.save
      render status: 422
    end
  end

end
