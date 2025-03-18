class LikesController < ApplicationController
    def new
      @like = Like.new
    end
    

    
def create
  @like = Like.new(like_params)
  book_owner_id = @like.book.user_id
  current_user_id = current_user.id
  second_like = Like.find_by(user_id: book_owner_id, book_id: current_user.books.pluck(:id))
  @like.save

  if second_like

    @match = Match.new(first_like_id: @like.id, second_like_id: second_like.id)

    if @match.save
      flash[:notice] = "Match registrado com sucesso!"
    else
      flash[:alert] = "Erro ao registrar match."
    end
  end
end
  private
  def like_params
    params.slice(:book_id, :user_id).permit!
  end
end


  

