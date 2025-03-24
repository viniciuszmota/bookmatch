# class LikesController < ApplicationController
#   def new
#     @like = Like.new
#   end



# def create
#   @like = Like.new(like_params)
#   book_owner_id = @like.book.user_id
#   current_user_id = current_user.id
#   second_like = Like.find_by(user_id: book_owner_id, book_id: current_user.books.pluck(:id))
#   @like.save

#   if second_like && @like.liked_action == true
#     if second_like.liked_action
#       @match = Match.create(first_like_id: @like.id, second_like_id: second_like.id)
#       if @match.save
#         flash[:notice] = "Match registrado com sucesso!"
#         redirect_to matching_path
#         return
#       else
#         flash[:alert] = "Erro ao registrar match."
#         redirect_to matchmaking_path
#         return
#       end
#     end
#    redirect_to matchmaking_path
#   end


#   private
#   def like_params
#     params.slice(:book_id, :user_id, :liked_action).permit!
#   end
# end
# end


#-------Sugestions-------

class LikesController < ApplicationController
  def create
    @like = Like.new(like_params)
    @like.user = current_user

    if @like.save
      Rails.logger.info "Like salvo: #{@like.inspect}"
      book_owner_id = @like.book.user_id
      second_like = Like.find_by(user_id: book_owner_id, book_id: current_user.books.pluck(:id))
      Rails.logger.info "Segundo like encontrado: #{second_like.inspect}" if second_like

      if second_like && @like.liked_action && second_like.liked_action
        @match = Match.create(first_like_id: @like.id, second_like_id: second_like.id)
        if @match.persisted?
          Rails.logger.info "Match criado com sucesso: #{@match.inspect}"
          flash[:notice] = "Match registrado com sucesso!"
          redirect_to matching_path and return
        else
          Rails.logger.error "Falha ao criar match: #{@match.errors.full_messages}"
          flash[:alert] = "Erro ao registrar match."
        end
      end
    else
      Rails.logger.error "Falha ao salvar like: #{@like.errors.full_messages}"
      flash[:alert] = "Erro ao registrar o like."
    end

    redirect_to matchmaking_path
  end

  private

  # Alteração para não exigir o aninhamento dos parâmetros
  def like_params
    params.permit(:book_id, :liked_action)
  end
end

