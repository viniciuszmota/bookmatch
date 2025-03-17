class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update]
  def index
    @books = current_user.books
  end
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.tag_list.empty?
      render :new, status: :unprocessable_entity
    else
      @book.user = current_user
      @book.tag_list = book_params[:tag_list]
      if @book.save
        redirect_to books_path, notice: "Successfully created book"
      else
        render :new, status: :unprocessable_entity
      end
    end
  end


  def show
    @books = Book.all
    # Armazena na sessão apenas os livros que não pertencem ao usuário logado
    if session[:books].nil?
      session[:books] = Book.where.not(user_id: current_user.id).shuffle.map(&:id)
    end

    # Pega o próximo livro do array (se existir)
    @book_id = session[:books].shift

    if @book_id
      @book = Book.find(@book_id)
    else
      # Se não houver mais livros, reinicia o array sem os livros do usuário
      session[:books] = Book.where.not(user_id: current_user.id).shuffle.map(&:id)
      @book_id = session[:books].shift
      @book = Book.find(@book_id) if @book_id
    end
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "Livro atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def accept
    # Aqui você pode adicionar lógica para registrar que o usuário aceitou o livro
    redirect_to books_path # Redireciona para o próximo livro
  end

  def reject
    # Aqui você pode adicionar lógica para registrar que o usuário recusou o livro
    redirect_to books_path # Redireciona para o próximo livro
  end


  def set_book
    @book = Book.find(params[:id])
    @user = current_user
  end

  def book_params
    params.require(:book).permit(:title, :author, :publisher, :condition, :tag_list)
  end
end
