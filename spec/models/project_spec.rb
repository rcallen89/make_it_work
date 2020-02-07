require 'rails_helper'


RSpec.describe Project, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :material}
  end

  describe "relationships" do
    it {should belong_to :challenge}
    it {should have_many :contestant_projects}
    it {should have_many(:contestants).through(:contestant_projects)}
  end

  describe 'number of contestants count' do
    it 'can calculate number of contestants per project' do
        
      challenge = Challenge.create!(theme: "Apartment Furnishings", project_budget: 100)
      project1 = Project.create!(name: "Litfit", material: "Lamp Shade", challenge_id: challenge.id)

      contestant1 = Contestant.create!(name: "Kentaro Kameyama", age: "20", hometown: "Denver", years_of_experience: "5")
      contestant2 = Contestant.create!(name: "Jay McCarrol", age: "20", hometown: "Denver", years_of_experience: "5")

      contestant_project = ContestantProject.create!(contestant_id: contestant1.id, project_id: project1.id)
      contestant_project = ContestantProject.create!(contestant_id: contestant2.id, project_id: project1.id)

      expect(project1.number_of_contestants).to eq(2)
    end
  end

  describe '#contestant_average_exp' do
    it 'can calculate average years of experience of contestants per project' do
        
      challenge = Challenge.create!(theme: "Apartment Furnishings", project_budget: 100)
      project1 = Project.create!(name: "Litfit", material: "Lamp Shade", challenge_id: challenge.id)

      contestant1 = Contestant.create!(name: "Kentaro Kameyama", age: "20", hometown: "Denver", years_of_experience: "10")
      contestant2 = Contestant.create!(name: "Jay McCarrol", age: "20", hometown: "Denver", years_of_experience: "11")

      contestant_project = ContestantProject.create!(contestant_id: contestant1.id, project_id: project1.id)
      contestant_project = ContestantProject.create!(contestant_id: contestant2.id, project_id: project1.id)

      expect(project1.contestant_average_exp).to eq(10.5)
    end
  end
end
