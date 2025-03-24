# class BooksController < ApplicationController
#   before_action :set_book, only: %i[show edit update destroy]
#   def index
#     @books = current_user.books
#     @book = Book.all
#   end
#   def new
#     @book = Book.new
#   end

#   def create
#     @book = Book.new(book_params)
#     if @book.tag_list.empty?
#       render :new, status: :unprocessable_entity
#     else
#       @book.user = current_user
#       @book.tag_list = book_params[:tag_list]
#       if @book.save
#         redirect_to books_path, notice: "Successfully created book"
#       else
#         render :new, status: :unprocessable_entity
#       end
#     end
#   end


#   def show
#     @books = Book.all
#     # Armazena na sessão apenas os livros que não pertencem ao usuário logado
#     if session[:books].nil?
#       session[:books] = Book.where.not(user_id: current_user.id).shuffle.map(&:id)
#     end

#     # Pega o próximo livro do array (se existir)
#     @book_id = session[:books].shift

#     if @book_id
#       @book = Book.find(@book_id)
#     else
#       # Se não houver mais livros, reinicia o array sem os livros do usuário
#       session[:books] = Book.where.not(user_id: current_user.id).shuffle.map(&:id)
#       @book_id = session[:books].shift
#       @book = Book.find(@book_id) if @book_id
#     end
#   end

#   def update
#     if @book.update(book_params)
#       redirect_to book_path(@book), notice: "Livro atualizado com sucesso."
#     else
#       render :edit, status: :unprocessable_entity
#     end
#   end

#   def destroy

#     likes = Like.where(book_id: @book.id)

#     matches = Match.where(first_like_id: likes.pluck(:id)).or(Match.where(second_like_id: likes.pluck(:id)))

#     matches.destroy_all if matches

#     likes.destroy_all if likes

#     @book.destroy

#     redirect_to books_path, notice: "Livro removido com sucesso."
#   end

#   private

#   def accept
#     # Aqui você pode adicionar lógica para registrar que o usuário aceitou o livro
#     redirect_to books_path # Redireciona para o próximo livro
#   end

#   def reject
#     # Aqui você pode adicionar lógica para registrar que o usuário recusou o livro
#     redirect_to books_path # Redireciona para o próximo livro
#   end


#   def set_book
#     @book = Book.find(params[:id])
#     @user = current_user
#   end

#   def book_params
#     params.require(:book).permit(:title, :author, :publisher, :condition, :tag_list, photos: [])
#   end
# end


#---------- Sugestions ----------

class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]

  def index
    @books = current_user.books
    @book = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user

    if @book.tag_list.empty?
      flash[:alert] = "O livro precisa ter ao menos uma tag!"
      render :new, status: :unprocessable_entity
    elsif @book.save
      redirect_to books_path, notice: "Livro criado com sucesso!"
    else
      flash[:alert] = "Erro ao salvar o livro."
      render :new, status: :unprocessable_entity
    end
  end

  def show
    if session[:books].nil? || session[:books].empty?
      session[:books] = Book.where.not(user_id: current_user.id).shuffle.map(&:id)
    end

    @book_id = session[:books].shift
    @book = Book.find_by(id: @book_id)

    unless @book
      session[:books] = Book.where.not(user_id: current_user.id).shuffle.map(&:id)
      @book = Book.find_by(id: session[:books].shift)
    end
  end

  def update
    if @book.update(book_params)
      redirect_to books_path, notice: "Livro atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    likes = Like.where(book_id: @book.id)
    matches = Match.where(first_like_id: likes.pluck(:id)).or(Match.where(second_like_id: likes.pluck(:id)))

    matches.destroy_all if matches.any?
    likes.destroy_all if likes.any?

    @book.destroy
    redirect_to books_path, notice: "Livro removido com sucesso."
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :publisher, :condition, :tag_list, photos: [])
  end
end
