class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :profile_image

  validates :name, presence: true, length: { in: 2..20 } #nameが2~20文字まで
  validates :name, presence: true        #空でないこと

  validates :introduction, presence: true, length: { maximum: 50 }, allow_blank: true

  #フォローできるユーザーを取り出すに記述
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  #フォローしているユーザーを取り出す （user.followingsをできるようにする）
  has_many :followings, through: :following_relationships

  #フォローされているユーザーを取り出す（user.follwersをできるようにする）
  has_many :follower_relationships, foreign_key: "following_id",class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships

  #user.rbにフォローする関数、フォローしているか調べるための関数、フォローを外す関数を作成
  def following?(other_user)
    following_relationships.find_by(following_id: other_user.id)
  end

  def follow!(other_user)
    following_relationships.create!(following_id: other_user.id)
  end

  def unfollow!(other_user)
    following_relationships.find_by(following_id: other_user.id).destroy
  end

  #searchメソッドの定義
  def self.search(method,word)
    if method == "forward_match"           # %をつける位置に注意!
        @users = User.where("name LIKE?","#{word}%")

    elsif method == "backward_match"
        @users = User.where("name LIKE?","%#{word}")

    elsif method == "perfect_match"
        @users = User.where("#{word}")

    elsif method == "partial_match"
        @users = User.where("name LIKE?","%#{word}%")

    else
        @users = User.all
    end
  end
  #ユーザー名による絞り込み
  scope :get_by_name, ->(name) {
    where("name LIKE?","%#{name}%")
  }
  #bookのtitleによる絞り込み
  scope :get_by_name, ->(title) {
    where("title LIKE?","%#{title}%")
  }
end
