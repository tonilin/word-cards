class WordsController < ApplicationController

  def index
    @word = Word.new

    @words = current_user.words.recent.all
  end

  def create
    @words = current_user.words.recent.all

    @word = Word.find_or_initialize_by_word(word_params[:word])

    if !@word.persisted?
      if !@word.save
        return render :index
      end
    end

    current_user.add_word!(@word)

    if @word.pending?
      YahooDicCrawler.new(@word).run
    end
    
    redirect_to words_path
  end



  private

  def word_params 
    params.require(:word).permit(:word)
  end


end
