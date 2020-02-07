require 'rails_helper'

RSpec.describe 'Contestants Index Page', type: :feature do
  before :each do
    @challenge = Challenge.create!(theme: "Apartment Furnishings", project_budget: 100)
    @project1 = Project.create!(name: "Litfit", material: "Lamp Shade", challenge_id: @challenge.id)
    @project2 = Project.create!(name: "Rug Tuxedo", material: "Lamp Shade", challenge_id: @challenge.id)
    @project3 = Project.create!(name: "LeatherFeather", material: "Lamp Shade", challenge_id: @challenge.id)

    @contestant1 = Contestant.create!(name: "Kentaro Kameyama", age: "20", hometown: "Denver", years_of_experience: "5")
    @contestant2 = Contestant.create!(name: "Jay McCarrol", age: "20", hometown: "Denver", years_of_experience: "5")

    @contestant_project = ContestantProject.create!(contestant_id: @contestant1.id, project_id: @project1.id)
    @contestant_project = ContestantProject.create!(contestant_id: @contestant1.id, project_id: @project2.id)
    @contestant_project = ContestantProject.create!(contestant_id: @contestant2.id, project_id: @project3.id)
  end
  context 'as a visitor' do
    it 'should so name and list of projects for each contestant' do
      visit "/contestants/"

      within "#contestant-#{@contestant1.id}" do
        expect(page).to have_content("Kentaro Kameyama")
        expect(page).to have_content("Projects: Litfit, Rug Tuxedo")
      end

      within "#contestant-#{@contestant2.id}" do
        expect(page).to have_content("Jay McCarrol")
        expect(page).to have_content("Projects: LeatherFeather")
      end
    end
  end
end