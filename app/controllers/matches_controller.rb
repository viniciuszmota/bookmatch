class MatchesController < ApplicationController
  def new
    @match = Match.new
  end
  
  def show
    @match = Match.find(params[:id])

    @message = Message.new   
  end
  def create
    @match = Match.new(match_params)
    if @match.save
      flash[:notice] = "Match registrado com sucesso!"
    else
      render :new
    end
  end
 
  def match_params
    params.require(:match).permit(:first_like_id, :second_like_id)
  end

end
