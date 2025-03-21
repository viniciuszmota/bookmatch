class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end
  
  def matchmaking
    @book = Book
            .where.not(user_id: current_user.id)
            .where.not(
              id: Like.where(user_id: current_user.id).select(:book_id)
            )
            .first
    @user = current_user

    # Armazena na sessão apenas os livros que não pertencem ao usuário logado

    # Pega o próximo livro do array (se existir)

      # Se não houver mais livros, reinicia o array sem os livros do usuário
  end

  def matching
    @matches = Match.includes(:first_like, :second_like)
    .where(first_like: { user_id: current_user.id })
    .or(Match.where(second_like: { user_id: current_user.id }))
  end
end
