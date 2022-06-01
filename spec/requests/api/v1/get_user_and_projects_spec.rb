require 'rails_helper'

RSpec.describe 'get user and projects' do

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

    it 'receives a GET request and returns user/projects' do
      get "/api/v1/users/#{User.last.id}"
      output = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(output[:type]).to eq("user")
      expect(output[:attributes][:id]).to eq(User.last.id)

      output[:attributes][:projects].each do |project|
        expect(project).to have_key(:projectName)
        expect(project).to have_key(:projectPet)
        expect(project).to have_key(:petHealth)
        expect(project).to have_key(:petLevel)
        expect(project).to have_key(:projectGitHub)
        expect(project).to have_key(:petImage)
        expect(project).to have_key(:stats)
        expect(project[:stats]).to have_key(:totalWorkTime)
        expect(project[:stats]).to have_key(:totalLongPomTime)
        expect(project[:stats]).to have_key(:totalLongSessions)
        expect(project[:stats]).to have_key(:totalShortPomTime)
        expect(project[:stats]).to have_key(:totalWorkSessions)
        expect(project[:stats]).to have_key(:totalShortSessions)
      end
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

    it 'receives a bad GET request and returns an error' do
      get "/api/v1/users/8675309"
      output = JSON.parse(response.body, symbolize_names: true)

      expect(output[:error]).to eq("User not found")
      expect(output[:status]).to eq("404")
    end
  end
end
