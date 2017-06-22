class Bracket < ApplicationRecord
  attr_accessor :children
  
  belongs_to :championship
  belongs_to :parent, class_name: 'Bracket', required: false
  belongs_to :winner, class_name: 'User', required: false
  belongs_to :player_1, class_name: 'User'
  belongs_to :player_2, class_name: 'User'
  
  def children
    @children ||= Bracket.where(parent_id: self.id)
  end

end