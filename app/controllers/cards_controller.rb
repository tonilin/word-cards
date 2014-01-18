class CardsController < ApplicationController


  def index
    @word = Word.new

    @cards = current_user.cards.recent_update.all
  end

  def create
    @cards = current_user.cards.recent_update.all

    @word = Word.find_or_create_by_content(word_params[:content])

    if !@word.persisted?
      return render :index
    end

    current_user.add_card!(@word, @word.explanations.first)
    redirect_to cards_path
  end

  def destroy
    @card = current_user.cards.find(params[:id])

    @card.destroy

    redirect_to :back
  end

  private

  def word_params 

    params.require(:word).permit(:content)
  end




end
