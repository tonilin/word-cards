class CardsController < ApplicationController


  def index
    @word = Word.new

    @cards = current_user.cards.recent.all
  end

  def create
    @cards = current_user.cards.recent.all

    @word = Word.find_or_initialize_by_word(word_params[:word])

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



  private

  def word_params 

    params.require(:word).permit(:word)
  end




end
