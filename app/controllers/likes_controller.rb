class LikesController < ApplicationController
    def new
      @like = Like.new
    end
    
    def create
      @like = Like.new(like_params)
      @like.user = current_user  # O usuário que está dando like
    
      if @like.save
        # Pegando o dono do livro que recebeu o like
        book_owner = @like.book.user
    
        # Verifica se o dono do livro já deu like em algum livro do current_user
        mutual_like = Like.exists?(user: book_owner, book: current_user.books)
    
        if mutual_like
          Match.create(first_user: book_owner, second_user: current_user)
        else
          flash[:notice] = "Like registrado com sucesso!"
        end
    
        redirect_to book_path(@like.book)
      else
        flash[:alert] = "Erro ao registrar o like."
        redirect_to books_path
      end
    end
    private
    def like_params
      # params.require(:like).permit(:book_id, :user_id)
    # rescue ActionController::ParameterMissing
      params.permit(:book_id, :user_id) # Permite parâmetros não aninhados
    end
  end
  

