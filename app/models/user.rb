class User < ActiveRecord::Base
	has_secure_password
	has_many :posts

	validates :email, uniqueness: true

  has_many :invites_sent, class_name: 'ChatInvite', foreign_key: 'host_id'
  has_many :invites_received, class_name: 'ChatInvite', foreign_key: 'guest_id'

  def is_my_friend?(my_friend)
    friendships.each do |friendship|
      if friendship.friend_id == my_friend.id
        return true
      end
    end
    return false
  end


  # has_many :friendships_sent, class_name: 'Friendship', foreign_key: 'person_id'
  # has_many :friendships_received, class_name: 'Friendship', foreign_key: 'friend_id'

  # def as_json(options = {})
  #     {
  #         id: self.id,
  #         username: self.username
  #     }
  # end

end
