class Book < ApplicationRecord
	belongs_to :user
	validates :user_id, presence: true
	validates :title, presence: true
    validates :body, presence: true, length: { maximum: 200 }
    has_many :book_comments, dependent: :destroy
    has_many :favorites, dependent: :destroy

  def favorited_by?(user)
  	favorites.where(user_id: user.id).exists?
  end


  #searchメソッドの定義
  def self.search(method,word)
  	if @search_content = "Book"
    if method == "forward_match"           # %をつける位置に注意!
        Book.where('title LIKE ?',"#{word}%")

    elsif method == "backward_match"
        Book.where('title LIKE ?',"%#{word}")

    elsif method == "perfect_match"
        Book.where("#{word}")

    elsif method == "partial_match"
        Book.where('title LIKE ?',"%#{word}%")

    else
        Book.all
    end
    end
  end

    #bookのtitleによる絞り込み
  scope :get_by_title, ->(title) {
    where("title LIKE?","%#{title}%")
  }
end
