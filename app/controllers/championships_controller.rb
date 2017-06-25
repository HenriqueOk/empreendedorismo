class ChampionshipsController < ApplicationController

  @@id_pontos_corridos = 1 #definir qual ID eh o de pontos corridos

  helper_method :id_pontos_corridos

  def id_pontos_corridos
    @@id_pontos_corridos
  end

  def index
    @championships = Array.new

    participations = Participant.where(user_id: current_user.id)

    participations.each do |participation|
      # if participation.championship.user_id != current_user.id
        @championships << participation.championship
      # end
    end

    #Informacoes de Ranking
    @rank = current_user.ranking

    if @rank == nil
      @rank = Ranking.new(user_id: current_user.id, played_games: 0, scheduled_games: 0, victories: 0, draws: 0, defeats: 0, points: 0, wins: 0, position: Ranking.count+1)
      @rank.save
    end

  end

  def new
    @championship = Championship.new
  end

  def create
    attributes = permitted_params
    attributes[:user] = current_user
    @championship = Championship.new(attributes)

    if(@championship.save)
      participants = Array.new

      #Salvar os participants
      params[:championship][:user_ids].each do |user_id|
        participant = Participant.new(championship_id: @championship.id, user_id: user_id)
        participant.save
        participants << participant
      end

      if @championship.championship_type_id == @@id_pontos_corridos
        for i in (1..participants.size-2)
          for j in (i+1..participants.size-1)
            partida = PontoscorridosPartida.new(championship_id: @championship.id, player1: participants[i], player2: participants[j], score_player1: 0, score_player2: 0, finished: false)
            partida.save
          end
        end

      else
        #Implementar caso de mata-mata
      end

      redirect_to @championship
    else
      render :new
    end
  end

  def show
    @championship = Championship.find(params[:id])
    if @championship.brackets?
      render :show_brackets
    else
      render :show_all_play_all
    end
  end

  def atualizar_partidas

    params[:score_player1].each do |k,v|
      if v != ""
        partida = PontoscorridosPartida.find_by_id(k)
        partida.score_player1 = v
        partida.finished = true
        partida.save
      end
    end

    params[:score_player2].each do |k,v|
      if v != ""
        partida = PontoscorridosPartida.find_by_id(k)
        partida.score_player2 = v
        partida.finished = true
        partida.save
      end
    end

    @championship = Championship.find_by_id(params[:id])

    respond_to do |format|
      format.js
    end

  end

  def finalizar_campeonato

    campeonato = Championship.find_by_id(params[:id])

    ranks = Array.new

    campeonato.participants.each do |participante|
        r = Ranking.new(user_id: participante.user_id, played_games: 0, victories: 0, draws: 0, defeats: 0, points: 0)
        ranks << r
    end

    campeonato.pontoscorridos_partidas.each do |partida|

      if partida.finished == false
        redirect_to championship_path, :id => params[:id], :alert => "Não é possível encerrar o campeonato. Há partidas sem resultado"
        return
      end

      #Sim, tudo isso e pra descobrir o vencedor -> me julgue
      p1 = ranks.find {|s| s.user_id == partida.player1 }
      p2 = ranks.find {|t| t.user_id == partida.player2 }

      p1.played_games += 1
      p2.played_games += 1

      if partida.score_player1 > partida.score_player2
          p1.points += 11
          p1.victories += 1
          p2.points += 1
          p2.defeats += 1
      end

      if partida.score_player2 > partida.score_player1
          p2.points += 11
          p2.victories += 1
          p1.points += 1
          p1.defeats += 1
      end

      if partida.score_player1 == partida.score_player2
          p1.points += 4
          p1.draws += 1
          p2.points += 4
          p2.draws += 1
      end

    end

    ranks2 = ranks.sort_by {|obj| [obj.points * -1, obj.victories * -1, obj.draws * -1, obj.user_id]}

    #Setar o vencedor
    campeonato.winner = ranks2[0].user_id
    campeonato.save

    #Recalcular o ranking geral
    %x[rake ranking:atualizar]

    redirect_to championships_path
  end

  private

    def permitted_params
      params.require(:championship).permit(:name, :game, :starts_at, :ends_at, :championship_type_id, :user_ids)
    end

end
