require 'rails_helper'

RSpec.describe 'update project' do

  describe 'happy path' do
    before :each do
      @user = User.create(username: "Ross",
                          email: "ross@vanMail.com",
                          profilePhoto: "url/ross-in-van.png",
                          settings: { :workTime => 25,
                                      :shortPomTime => 5,
                                      :longPomTime => 10})
      @project_1 = Project.create(projectName: "stretch-tech",
                                  projectPet: "pigeon",
                                  petHealth: 3,
                                  petLevel: 1,
                                  projectGitHub: "url/ross-van-stretch-tech.com",
                                  petImage: "url/PigeonPet.png",
                                  user_id: User.last.id,
                                  stats: {:totalWorkTime => 175,
                                          :totalWorkSessions => 5,
                                          :totalShortPomTime => 45,
                                          :totalShortSessions => 8,
                                          :totalLongPomTime => 100,
                                          :totalLongSessions => 4})
      @project_2 = Project.create(projectName: "shrink-tech",
                                  projectPet: "tomato",
                                  petHealth: 1000,
                                  petLevel: 5000,
                                  projectGitHub: "tomato-wins.com",
                                  petImage: "tomato-pic-url",
                                  user_id: User.last.id,
                                  stats: {:totalWorkTime => 5,
                                          :totalWorkSessions => 1,
                                          :totalShortPomTime => 20,
                                          :totalShortSessions => 5,
                                          :totalLongPomTime => 500,
                                          :totalLongSessions => 9})
    end

    it 'can update part of a projects nested attributes' do
      attr_before = Project.last.stats["totalWorkTime"]
      new_params = { stats: { totalWorkTime: 500 }}
      headers = {"CONTENT_TYPE" => "application/json"}
      patch "/api/v1/projects/#{Project.last.id}", headers: headers, params: JSON.generate({project: new_params})
      expect(response).to be_successful
      expect(Project.last.stats["totalWorkTime"]).to_not eq(attr_before)
      expect(Project.last.stats["totalWorkTime"]).to eq(new_params[:stats][:totalWorkTime].to_s)
    end

    it 'can update part of a projects normal attributes' do
      attr_before = Project.last.projectPet
      new_params = { projectPet: "bibby" }
      headers = {"CONTENT_TYPE" => "application/json"}
      patch "/api/v1/projects/#{Project.last.id}", headers: headers, params: JSON.generate({project: new_params})
      expect(response).to be_successful
      expect(Project.last.projectPet).to_not eq(attr_before)
      expect(Project.last.projectPet).to eq(new_params[:projectPet])
    end
  end

  describe 'sad path' do
    before :each do
      @user = User.create(username: "Ross",
                          email: "ross@vanMail.com",
                          profilePhoto: "url/ross-in-van.png",
                          settings: { :workTime => 25,
                                      :shortPomTime => 5,
                                      :longPomTime => 10})
      @project_1 = Project.create(projectName: "stretch-tech",
                                  projectPet: "pigeon",
                                  petHealth: 3,
                                  petLevel: 1,
                                  projectGitHub: "url/ross-van-stretch-tech.com",
                                  petImage: "url/PigeonPet.png",
                                  user_id: User.last.id,
                                  stats: {:totalWorkTime => 175,
                                          :totalWorkSessions => 5,
                                          :totalShortPomTime => 45,
                                          :totalShortSessions => 8,
                                          :totalLongPomTime => 100,
                                          :totalLongSessions => 4})
      @project_2 = Project.create(projectName: "shrink-tech",
                                  projectPet: "tomato",
                                  petHealth: 1000,
                                  petLevel: 5000,
                                  projectGitHub: "tomato-wins.com",
                                  petImage: "tomato-pic-url",
                                  user_id: User.last.id,
                                  stats: {:totalWorkTime => 5,
                                          :totalWorkSessions => 1,
                                          :totalShortPomTime => 20,
                                          :totalShortSessions => 5,
                                          :totalLongPomTime => 500,
                                          :totalLongSessions => 9})
    end

  end
end
