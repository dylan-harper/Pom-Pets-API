class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :username, :email, :profilePhoto, :settings

  attribute :projects do |object|
    object.projects
  end
end
