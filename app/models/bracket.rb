class Bracket < ApplicationRecord
  attr_accessor :children

  belongs_to :championship
  belongs_to :parent, class_name: 'Bracket', required: false
  belongs_to :winner, class_name: 'Player', required: false
  belongs_to :player_1, class_name: 'Player', required: false
  belongs_to :player_2, class_name: 'Player', required: false

  def children
    @children ||= Bracket.where(parent_id: self.id)
  end

  def finished?
    self.winner.present?
  end

  def final?
    parent_id.blank?
  end

  def completed?
    player_2_id.present? && player_1_id.present?
  end
end
