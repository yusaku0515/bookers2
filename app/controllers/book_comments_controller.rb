class BookCommentsController < ApplicationController

	def create
	    book = Book.find(params[:book_id])
	    comment = current_user.book_comments.new(book_comment_params)
	    comment.book_id = book.id
	    comment.save
	    redirect_back(fallback_location: root_path)
	end

	def destroy
		book = BookComment.find(params[:book_id])
		comment = current_user.book_comments.find_by(comment)
		comment.destroy
		redirect_back(fallback_location: root_path)
	end

	private
	def book_comment_params
		params.require(:book_comment).permit(:comment)
	end

	def correct_user
		@comment = current_user.comments.find_by(id: params[:id])
		unless @comment
			redirect_back(fallback_location: root_path)
		end
	end
end
