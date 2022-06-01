require 'rails_helper'

RSpec.describe Project do
  describe 'relationships' do
    it { should belong_to :user }
  end

  describe 'validations' do
    it { should validate_presence_of(:projectName) }
    it { should validate_presence_of(:projectPet) }
    it { should validate_presence_of(:petHealth) }
    it { should validate_presence_of(:petLevel) }
    it { should validate_presence_of(:projectGitHub) }
    it { should validate_presence_of(:petImage) }
    it { should validate_presence_of(:petImage) }
    it { should validate_presence_of(:stats) }
    it { should validate_presence_of(:user_id) }
  end
end
