class LikesController < ApplicationController
    def new
      @like = Like.new
    end
    

    
  def create
  @like = Like.new(like_params)

  if @like.save
    # Verifica se já existe um like recíproco
    second_like = Like.find_by(user_id: @like.book.user_id, book_id: @like.user.books.pluck(:id))

    if second_like
      @match = Match.new(first_like_id: @like.id, second_like_id: second_like.id)

      if @match.save
        flash[:notice] = "Match registrado com sucesso!"
      else
        flash[:alert] = "Erro ao registrar match."
      end
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  else
    flash[:alert] = "Erro ao dar like."
    redirect_to root_path
  end
end
    private
    def like_params
      params.slice(:book_id, :user_id).permit!
    end
end


  

