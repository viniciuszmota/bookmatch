class MatchesController < ApplicationController
  def new
    @match = Match.new
    @book = Book.new
    @user = current_user
  end
  
  def create
    @match = Match.new(first_user_id: params[:first_user_id], second_user_id: params[:second_user_id])
    if @match.save
      flash[:notice] = "Match registrado com sucesso!"
    else
      render: new
    end
  end
 
  def match_params
    params.require(:match).permit(:attendee_id, :requestee_id)
  end

end
