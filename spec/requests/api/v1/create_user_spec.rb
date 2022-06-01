require 'rails_helper'

RSpec.describe 'create user' do
  it 'receives a POST request to create a user' do
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
    expect(response).to be_successful
    expect(response.status).to eq(200)
    user = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(user[:type]).to eq("user")
    expect(user[:id]).to eq(User.last.id.to_s)
    expect(user[:attributes][:username]).to eq("Ross")
    expect(user[:attributes][:email]).to eq("ross@vanMail.com")
    expect(user[:attributes][:profilePhoto]).to eq("url/ross-in-van.png")
    expect(user[:attributes][:settings][:workTime]).to eq("25")
    expect(user[:attributes][:settings][:shortPomTime]).to eq("5")
    expect(user[:attributes][:settings][:longPomTime]).to eq("10")
  end
end
