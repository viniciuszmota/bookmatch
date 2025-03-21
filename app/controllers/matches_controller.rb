class MatchesController < ApplicationController
  before_action :match_params, only: [:create]

  def index
    @matches = Match.includes(:first_like, :second_like)
    .where(first_like: { user_id: current_user.id })
    .or(Match.where(second_like: { user_id: current_user.id }))

  end


  def new
    @match = Match.new
  end


  def show
    @match = Match.find(params[:id])
    @message = Message.new
    @match.messages.unread_by(current_user).update_all(read: true)
  end


  def create
    @match = Match.new(match_params)
    if @match.save
      flash[:notice] = "Match registrado com sucesso!"
      redirect_to matching_path
    else
      render :new
    end
  end

  def destroy
    @match = Match.find(params[:id])
    @match.destroy
    redirect_to matches_path
  end


  private
  def match_params
    params.require(:match).permit(:first_like_id, :second_like_id)
  end

end
