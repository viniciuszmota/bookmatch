class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update]

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

  def index
    @books = current_user.books
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
    params.require(:book).permit(:title, :author, :publisher, :condition, :tag_list)
  end
end
