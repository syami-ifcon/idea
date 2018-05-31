class List < ApplicationRecord
	mount_uploaders :picture, AvatarUploader
	validates :title, presence: true
	validates :content, presence: true
	belongs_to :user
end