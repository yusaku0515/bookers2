class Book < ApplicationRecord
	belongs_to :user
	validates :user_id, presence: true
	validates :title, presence: true
    validates :body, presence: true, length: { maximum: 200 }

	# def user
	# 	return User.find_by(id: self.user_id)
	# end
end
