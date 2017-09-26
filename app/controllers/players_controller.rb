class PlayersController < ApplicationController

  def create
    @player = Player.new(name: params[:name], championship_id: params[:championship_id])
    unless @player.save
      render status: 422
    end
  end

  def create_many
    @players = []
    if params[:players_count].present?
      Player.transaction do
        params[:players_count].to_i.times do |i|
          @players.push Player.create(name: "Jogador #{i+1}", championship_id: params[:championship_id])
        end
      end
    end
  end

end
