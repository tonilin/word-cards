module WordsHelper

  def render_word_content(word) 
    if word
      capitalize_first_char(word.content)
    end
  end

end
