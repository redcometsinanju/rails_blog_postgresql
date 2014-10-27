class Post < ActiveRecord::Base
	mount_uploader :image, ImageUploader
	has_many :comments
	belongs_to :user
	validates :title, presence: true
	validates :description, presence: true

end
