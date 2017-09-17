class Championship < ApplicationRecord
  
  validates_uniqueness_of :name

end
