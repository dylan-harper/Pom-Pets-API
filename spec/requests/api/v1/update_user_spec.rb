require 'rails_helper'

RSpec.describe 'update user' do
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

    it 'can update part of a users nested attributes' do
      attr_before = User.last.settings["workTime"]
      new_params = { settings: { workTime: 8675309 }}
      headers = {"CONTENT_TYPE" => "application/json"}
      patch "/api/v1/users/#{User.last.id}", headers: headers, params: JSON.generate({user: new_params})
      expect(response).to be_successful
      expect(User.last.settings["workTime"]).to_not eq(attr_before)
      expect(User.last.settings["workTime"]).to eq(new_params[:settings][:workTime].to_s)
    end

    it 'can update part of a users normal attributes' do
      attr_before = User.last.username
      new_params = { username: "bibby" }
      headers = {"CONTENT_TYPE" => "application/json"}
      patch "/api/v1/users/#{User.last.id}", headers: headers, params: JSON.generate({user: new_params})
      expect(response).to be_successful
      expect(User.last.username).to_not eq(attr_before)
      expect(User.last.username).to eq(new_params[:username])
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

    it 'cannot update part of a projects nested attributes' do
      new_params = { settings: { werkTime: 500 }}
      headers = {"CONTENT_TYPE" => "application/json"}
      patch "/api/v1/users/#{User.last.id}", headers: headers, params: JSON.generate({user: new_params})
      output = JSON.parse(response.body, symbolize_names: true)
      expect(output[:status]).to eq("400 Bad Request")
    end

    it 'cannot update part of a projects normal attributes' do
      new_params = { usahname: "bibby" }
      headers = {"CONTENT_TYPE" => "application/json"}
      patch "/api/v1/users/#{User.last.id}", headers: headers, params: JSON.generate({user: new_params})
      output = JSON.parse(response.body, symbolize_names: true)
      expect(output[:status]).to eq("400 Bad Request")
    end
  end
end
