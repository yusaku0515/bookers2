class UserImage < ApplicationRecord
	beings_to :user
	attachment :image
end
