class CardsController < AuthenticatedController

  def index
    @cards = current_user.cards.recent_update.all

  end


  def create
    @cards = current_user.cards.recent_update.all

    @word = YahooDicCrawler.new(word_params[:content]).run

    current_user.add_card!(@word, @word.explanations.first)

    redirect_to :back
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
