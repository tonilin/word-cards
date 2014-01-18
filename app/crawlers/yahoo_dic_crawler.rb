class YahooDicCrawler

  def initialize(word)
    @word = word
    @crawler = Crawler.new(@word.word)
  end

  def save_result_to_db(record)
    @word.explanation = @crawler.explanation
    @word.status = "success"
    @word.save
  end

  def currenting_word
    currect_word = Word.find_or_initialize_by_word(@word.word)

    if !currect_word.persisted?
      save_result_to_db(currect_word)
    end

    return currect_word
  end

  def run
    @crawler.run

    if !@crawler.success?
      @word.fail!
      return
    end

    if @crawler.exactly_hit?
      save_result_to_db(@word)
      return
    end

    current_word = currenting_word

    @word.users.each do |user|
      user.words << current_word
    end

    @word.destroy

  end


end