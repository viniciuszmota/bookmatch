class MatchesController < ApplicationController
  def new
    @match = Match.new
    @book = Book.new
    @user = current_user
  end
  
  def create
    @match = Match.new(first_like_id: params[:first_like_id], second_like_id: params[:second_like_id])
    if @match.save
      flash[:notice] = "Match registrado com sucesso!"
    else
      render: new
    end
  end
 
  def match_params
    params.require(:match).permit(:first_like_id, :second_like_id)
  end

end
