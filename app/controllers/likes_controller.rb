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
      if second_like.liked_action
        @match = Match.create(first_like_id: @like.id, second_like_id: second_like.id)
        if @match.save
          flash[:notice] = "Match registrado com sucesso!"
        else
          flash[:alert] = "Erro ao registrar match."
        end
      end
    end
    redirect_to matchmaking_path
  end

  
    private
    def like_params
      params.slice(:book_id, :user_id, :liked_action).permit!
    end
end


  

