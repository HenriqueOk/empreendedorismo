class Interest < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :participants, class_name: 'User'

  scope :by_format, -> (format) do
    where('lower(format) LIKE ?', "%#{format.downcase}%")
  end

  scope :by_local, -> (local) do
    where('lower(local) LIKE ?', "%#{local.downcase}%")
  end

  validates_presence_of :format, :local, :datetime
end
