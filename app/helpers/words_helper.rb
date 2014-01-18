module WordsHelper

  def render_word_content(word) 
    word.content if word
  end

end
