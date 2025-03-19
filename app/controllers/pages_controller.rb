class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def matchmaking
    @book = Book
            .left_joins(:likes) # Faz um LEFT JOIN com a tabela de likes
            .where.not(user_id: current_user.id) # Evita que o usuário veja seus próprios livros
            .where("likes.user_id IS NULL OR likes.user_id != ?", current_user.id).first
    @user = current_user
    # Armazena na sessão apenas os livros que não pertencem ao usuário logado
    
    # Pega o próximo livro do array (se existir)

      # Se não houver mais livros, reinicia o array sem os livros do usuário
  end
    
end



