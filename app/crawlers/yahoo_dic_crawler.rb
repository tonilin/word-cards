class YahooDicCrawler

  def initialize(word)
    @word = word
    @crawler = Crawler.new(@word.content)
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

    currect_word = Word.find_or_create_by_content(@crawler.word)

    @word.fail!
  end


end