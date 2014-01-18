class CardsController < ApplicationController


  def index
    @word = Word.new

    @cards = current_user.cards.recent_update.all
  end

  def create
    @cards = current_user.cards.recent_update.all

    @word = Word.find_or_initialize_by_content(word_params[:content])

    if !@word.persisted?
      if @word.save
        current_user.add_card!(@word, nil)
        YahooDicCrawler.new(@word).run
        return redirect_to cards_path
      else
        return render :index
      end
    end

    current_user.add_card!(@word, @word.explanations.first)

    redirect_to cards_path
  end

  def destroy

  end


  private

  def word_params 

    params.require(:word).permit(:content)
  end




end
