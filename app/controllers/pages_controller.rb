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
  
  end
    
end



