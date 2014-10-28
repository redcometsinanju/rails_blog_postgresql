class User < ActiveRecord::Base
	has_secure_password
	has_many :posts

	validates :email, uniqueness: true

  has_many :friendships_sent, class_name: 'Friendship', foreign_key: 'person_id'
  has_many :friendships_received, class_name: 'Friendship', foreign_key: 'friend_id'

  # def as_json(options = {})
  #     {
  #         id: self.id,
  #         username: self.username
  #     }
  # end

end
