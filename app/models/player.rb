class Player < ApplicationRecord
  belongs_to :championship

  validates_presence_of :name
end
