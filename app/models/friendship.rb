class Friendship < ActiveRecord::Base
  belongs_to :person, class_name: 'User', foreign_key: 'person_id'
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  # validates :source, presence: true
  # validates :target, presence: true

  # def as_json(options = {})
  #     super(options).merge({
  #         errors: self.errors,
  #         target: self.target,
  #         source: self.source
  #     })
  # end
end
