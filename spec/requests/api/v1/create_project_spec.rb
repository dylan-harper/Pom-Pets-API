require 'rails_helper'

RSpec.describe 'create project' do
  describe 'happy path' do

    before :each do
      headers = { 'CONTENT_TYPE' => 'application/json' }
      payload = {
        "username": "Ross",
        "email": "ross@vanMail.com",
        "profilePhoto": "url/ross-in-van.png",
        "settings": {
          "workTime": 25,
          "shortPomTime": 5,
          "longPomTime": 10
        }
      }

      post '/api/v1/users', headers: headers, params: payload.to_json
    end

    it 'receives a POST request to create a project' do
      headers = { 'CONTENT_TYPE' => 'application/json' }
      payload = {
        "projectName": "stretch-tech",
        "projectPet": "pigeon",
        "petHealth": 3,
        "petLevel": 1,
        "projectGitHub": "url/ross-van-stretch-tech.com",
        "petImage": "url/PigeonPet.png",
        "user_id": User.last.id,
        "stats": {
          "totalWorkTime": 175,
          "totalWorkSessions": 5,
          "totalShortPomTime": 45,
          "totalShortSessions": 8,
          "totalLongPomTime": 100,
          "totalLongSessions": 4
         }
       }

       post '/api/v1/projects', headers: headers, params: payload.to_json
       expect(response).to be_successful
       expect(response.status).to eq(200)

       project = JSON.parse(response.body, symbolize_names: true)[:data]
       expect(project[:type]).to eq('project')
       expect(project[:attributes]).to have_key(:projectName)
       expect(project[:attributes]).to have_key(:projectPet)
       expect(project[:attributes]).to have_key(:petHealth)
       expect(project[:attributes]).to have_key(:petLevel)
       expect(project[:attributes]).to have_key(:projectGitHub)
       expect(project[:attributes]).to have_key(:petImage)
       expect(project[:attributes]).to have_key(:user_id)
       expect(project[:attributes][:stats]).to have_key(:totalWorkTime)
       expect(project[:attributes][:stats]).to have_key(:totalWorkSessions)
       expect(project[:attributes][:stats]).to have_key(:totalShortPomTime)
       expect(project[:attributes][:stats]).to have_key(:totalShortSessions)
       expect(project[:attributes][:stats]).to have_key(:totalLongPomTime)
       expect(project[:attributes][:stats]).to have_key(:totalLongSessions)
       expect(project[:relationships][:user][:data][:id]).to eq(User.last.id.to_s)
    end
  end

  describe 'sad path' do
    before :each do
      headers = { 'CONTENT_TYPE' => 'application/json' }
      payload = {
        "username": "Ross",
        "email": "ross@vanMail.com",
        "profilePhoto": "url/ross-in-van.png",
        "settings": {
          "workTime": 25,
          "shortPomTime": 5,
          "longPomTime": 10
        }
      }

      post '/api/v1/users', headers: headers, params: payload.to_json
    end

    it 'receives a bad POST request to create a project' do
      headers = { 'CONTENT_TYPE' => 'application/json' }
      payload = {
        "projectName": "stretch-tech",
        "petHealth": 3,
        "petLevel": 1,
        "projectGitHub": "url/ross-van-stretch-tech.com",
        "petImage": "url/PigeonPet.png",
        "user_id": User.last.id,
        "stats": {
          "totalWorkTime": 175,
          "totalWorkSessions": 5,
          "totalShortPomTime": 45,
          "totalShortSessions": 8,
          "totalLongPomTime": 100,
          "totalLongSessions": 4
         }
       }

       post '/api/v1/projects', headers: headers, params: payload.to_json
       expect(response).to_not be_successful
       expect(response.status).to eq(400)

       output = JSON.parse(response.body, symbolize_names: true)
       expect(output[:error][:projectPet]).to eq(["can't be blank"])
       expect(output[:status]).to eq("400 Bad Request")
    end

  end
end
