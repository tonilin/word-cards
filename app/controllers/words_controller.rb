class WordsController < ApplicationController

  def index
    @word = Word.new
  end

  def create
    group = current_user.words.build(word_params)

    if current_user.save
      redirect_to words_path
    else
      render :index
    end


  end



  private

  def word_params 
    params.require(:word).permit(:word)
  end


end
