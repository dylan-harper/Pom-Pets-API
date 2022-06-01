class ProjectSerializer
  include JSONAPI::Serializer
  belongs_to :user
  attributes :projectName,
             :projectPet,
             :petHealth,
             :petLevel,
             :projectGitHub,
             :petImage,
             :user_id,
             :stats
end
