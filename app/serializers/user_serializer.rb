class UserSerializer
  include JSONAPI::Serializer
  has_many :projects
  attributes :id, :username, :email, :profilePhoto, :settings
end
