class List < ApplicationRecord
	belongs_to :user
	mount_uploaders :picture, AvatarUploader
end