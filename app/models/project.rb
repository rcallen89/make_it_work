class Project < ApplicationRecord
  validates_presence_of :name, :material
  belongs_to :challenge

  has_many :contestant_projects
  has_many :contestants, through: :contestant_projects

  def number_of_contestants
    self.contestants.count
  end

  def contestant_average_exp
    self.contestants.average(:years_of_experience)
  end
end
