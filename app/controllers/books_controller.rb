class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update]

  def new
    @book = Book.new
    @genres= Genre.all
  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user
    if @book.save
      redirect_to books_path, notice: "Successfully created book"
    else
      @genres = Genre.all
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @books = Book.all
  end

  def show
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "Livro atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :publisher, :condition, :genre_id)
  end
end
