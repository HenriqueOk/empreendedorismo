class Championship < ApplicationRecord
  class InvalidParticipantsNumber < StandardError; end;
  class InvalidChampionshipType < StandardError; end;

  has_many :players
  has_many :brackets

  validates_uniqueness_of :name

  def brackets?
    true
  end

  def full_loaded_final(*relations_to_include)
    all_brackets = brackets.order(created_at: :desc).includes(*relations_to_include).to_a

    all_brackets.each do |bracket|
      bracket.children = all_brackets.select { |b| b.parent_id == bracket.id}
    end

    all_brackets.find { |bracket| bracket.parent_id.nil? }
  end

  def generate_brackets!
    raise InvalidParticipantsNumber if Math.log2(players.count) != Math.log2(players.count).to_i
    raise InvalidChampionshipType unless self.brackets?

    current_players = players.to_a.clone

    brackets = []
    while current_players.present?
      bracket = Bracket.new(championship_id: self.id)
      bracket.player_1 = current_players.delete(current_players.sample)
      bracket.player_2 = current_players.delete(current_players.sample)
      bracket.save!
      brackets << bracket
    end
    Bracket.transaction do
      current_round = brackets
      while current_round.size > 1
        next_round = []
        while current_round.present?
          parent = Bracket.create!(championship_id: self.id)

          bracket1 = current_round.pop
          bracket1.parent = parent
          bracket1.save!

          bracket2 = current_round.pop
          bracket2.parent = parent
          bracket2.save!

          next_round << parent
        end
        current_round = next_round
      end
    end
  end
end
