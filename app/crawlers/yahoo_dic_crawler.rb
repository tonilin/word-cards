class YahooDicCrawler

  def initialize(word)
    @word = word
    @crawler = Crawler.new(@word.word)
  end

  def save_result_to_db(record)
    @word.success!

    @crawler.explanations.each do |explanation|
      @word.explanations.create({
        pos: explanation[:pos],
        content: explanation[:content]
      })
    end



  end

  def currecting_word
    currect_word = Word.find_or_initialize_by_word(@crawler.word)

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

      @word.cards.without_explanation.each do |card|
        card.explanation = @word.explanations.first
        card.save
      end

      return
    end

    currect_word = currecting_word

    @word.cards.each do |card|
      card.user.add_card!(currect_word, currect_word.explanations.first)
    end

    @word.destroy

  end


end