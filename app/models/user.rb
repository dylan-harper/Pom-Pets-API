class User < ApplicationRecord
  validates_uniqueness_of :email, :username
  validates_presence_of :email,
                        :username,
                        :profilePhoto,
                        :settings

end
