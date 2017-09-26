class ChampionshipsController < ApplicationController

  def search
  end

  def find
    @championship = Championship.where(name: params[:name]).first

    if @championship.present?
      redirect_to championship_path(@championship.id)
    else
      @championship_name = params[:name]
      render :confirm_creation
    end
  end

  def create
    @championship = Championship.create(name: params[:name])
    render :add_players
  end

  def show
    @championship = Championship.find(params[:id])
  end

  def finish_creation
    @championship = Championship.find(params[:id])
    @championship.generate_brackets!

    redirect_to @championship
  end
end
