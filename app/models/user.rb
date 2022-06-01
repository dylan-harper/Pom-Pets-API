class User < ApplicationRecord
  has_many :projects, :dependent => :destroy

  validates_uniqueness_of :email, :username
  validates_presence_of :email,
                        :username,
                        :profilePhoto,
                        :settings

end
