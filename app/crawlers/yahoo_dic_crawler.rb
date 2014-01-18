class YahooDicCrawler

  def initialize(word_content)
    @word_content = word_content
    @crawler = Crawler.new(@word_content)
  end

  def save_result_to_db(record)
    record.success!

    @crawler.explanations.each do |explanation|

      record.explanations.create({
        pos: explanation[:pos],
        content: explanation[:content]
      })
    end

  end

  def run
    @word = Word.find_by_content(@word_content)

    if @word
      if @word.success?
        return @word
      elsif @word.fail?
        return @word.currect_word if @word.currect_word
        return @word
      end

    else
      word = Word.create({:content => @word_content})

      @crawler.run

      if @crawler.success?
        if @crawler.exactly_hit?
          save_result_to_db(word)

          return word
        else
          currect_word = Word.find_or_create_by_content(@crawler.word)

          if currect_word.pending?
            save_result_to_db(currect_word)
          end

          word.currect_word = currect_word
          word.status = "fail"
          word.save

          return currect_word
        end
      else
        word.fail!
        return word
      end
    end
  end


end