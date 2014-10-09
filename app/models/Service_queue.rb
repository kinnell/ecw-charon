class ServiceQueue < ActiveRecord::Base
  validates :name, presence: true

  has_many :tickets, dependent: :destroy

  def specialties_array
    specialties ? specialties.split(", ") : [""]
  end

end
