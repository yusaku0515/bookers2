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
  def Book.search(search, user_or_book, how_search)
  	if user_or_book == "title"
    if how_search == "forward_match"           # %をつける位置に注意!
        Book.where('title LIKE ?',"#{search}%")

    elsif how_search == "backward_match"
        Book.where('title LIKE ?',"%#{search}")

    elsif how_search == "perfect_match"
        Book.where('title LIKE ?',"#{search}")

    elsif how_search == "partial_match"
        Book.where('title LIKE ?',"%#{search}%")

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
