class List < ApplicationRecord
	validates :title, presence: true
	validates :content, presence: true
	belongs_to :user
	mount_uploaders :picture, AvatarUploader
end