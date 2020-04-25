class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy

  attachment :profile_image

  validates :name, presence: true, length: { in: 2..20 } #nameが2~20文字まで
  validates :name, presence: true        #空でないこと
  validates :introduction, presence: true, length: { maximum: 50 }

  def user
  	  return User.find_by(id: self.user_id)
  end
end
