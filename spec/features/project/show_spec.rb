require 'rails_helper'

RSpec.describe 'Project Show Page', type: :feature do
  before :each do
    @challenge = Challenge.create!(theme: "Apartment Furnishings", project_budget: 100)
    @project1 = Project.create!(name: "Litfit", material: "Lamp Shade", challenge_id: @challenge.id)
    @project2 = Project.create!(name: "Rug Tuxedo", material: "Lamp Shade", challenge_id: @challenge.id)
    @project3 = Project.create!(name: "LeatherFeather", material: "Lamp Shade", challenge_id: @challenge.id)

    @contestant1 = Contestant.create!(name: "Kentaro Kameyama", age: "20", hometown: "Denver", years_of_experience: "10")
    @contestant2 = Contestant.create!(name: "Jay McCarrol", age: "20", hometown: "Denver", years_of_experience: "11")
    @contestant3 = Contestant.create!(name: "Davis McDavy", age: "20", hometown: "Denver", years_of_experience: "12")

    @contestant_project = ContestantProject.create!(contestant_id: @contestant1.id, project_id: @project1.id)
    @contestant_project = ContestantProject.create!(contestant_id: @contestant1.id, project_id: @project2.id)
    @contestant_project = ContestantProject.create!(contestant_id: @contestant2.id, project_id: @project1.id)
  end

  context 'as a visitor' do
    it 'should show name, material and theme for project' do
      visit "/projects/#{@project1.id}"

      expect(page).to have_content("Litfit")
      expect(page).to have_content("Material: Lamp Shade")
      expect(page).to have_content("Challenge Theme: Apartment Furnishings")
    end

    it 'should show number of contestants on this project' do
      visit "/projects/#{@project1.id}"

      expect(page).to have_content("Litfit")
      expect(page).to have_content("Material: Lamp Shade")
      expect(page).to have_content("Challenge Theme: Apartment Furnishings")
      expect(page).to have_content("Number of Contestants: 2")
    end

    it 'should show average years of experience for contestants on this project' do
      visit "/projects/#{@project1.id}"

      expect(page).to have_content("Litfit")
      expect(page).to have_content("Material: Lamp Shade")
      expect(page).to have_content("Challenge Theme: Apartment Furnishings")
      expect(page).to have_content("Number of Contestants: 2")
      expect(page).to have_content("Average Contestant Experience: 10.5 years")
    end

    it 'should show a form to add a contestant to the project' do
      visit "/projects/#{@project1.id}"

      expect(page).to have_content("Litfit")
      expect(page).to have_content("Material: Lamp Shade")
      expect(page).to have_content("Challenge Theme: Apartment Furnishings")
      expect(page).to have_content("Number of Contestants: 2")
      expect(page).to have_content("Average Contestant Experience: 10.5 years")

      fill_in :contestant_id, with: "#{@contestant3.id}"
      click_on "Add Contestant"

      expect(current_path).to eq("/projects/#{@project1.id}")

      expect(page).to have_content("Litfit")
      expect(page).to have_content("Material: Lamp Shade")
      expect(page).to have_content("Challenge Theme: Apartment Furnishings")
      expect(page).to have_content("Number of Contestants: 3")
      expect(page).to have_content("Average Contestant Experience: 11.0 years")
    end
  end
end