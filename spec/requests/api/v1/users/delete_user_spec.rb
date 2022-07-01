require 'rails_helper'

RSpec.describe  'delete user' do
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

    it 'can successfully delete a user and its dependent projects' do
      expect(User.all.length).to eq(1)
      delete "/api/v1/users/#{@user.id}"
      expect(User.all).to eq([])
      expect(Project.all).to eq([])
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

    it 'can handle invalid IDs' do
      expect(User.all.length).to eq(1)
      delete "/api/v1/users/8675309"
      expect(response.status).to eq(400)
      output = JSON.parse(response.body, symbolize_names: true)
      expect(output[:error]).to eq("User with ID 8675309 does not exist")
      expect(User.all.length).to eq(1)
    end
  end
end
