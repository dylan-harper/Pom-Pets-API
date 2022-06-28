class Project < ApplicationRecord
  belongs_to :user

  validates_presence_of :projectName,
                        :projectPet,
                        :petHealth,
                        :petLevel,
                        :projectGitHub,
                        :petImage,
                        :stats,
                        :user_id                      
end
