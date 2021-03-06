require 'rails_helper'

RSpec.describe User do
  describe 'relationships' do
    it { should have_many(:projects).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:profilePhoto) }
    it { should validate_presence_of(:settings) }
  end
end
