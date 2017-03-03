class User < ApplicationRecord
  validates :name, :email, presence:true
  validates :email, uniqueness:true

  def self.create_from_github(auth)
    User.create!(
      github_id: auth['uid'],
      name: auth['info']['name'],
      email: auth['info']['email']
    )
  end
  
  def self.create_from_facebook(auth)
    User.create!(
      facebook_id: auth['uid'],
      name: auth['info']['name'],
      email: auth['info']['email']
    )
  end
end
