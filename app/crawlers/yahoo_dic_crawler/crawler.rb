class YahooDicCrawler::Crawler

  def initialize(word_for_search)
    @mechanize = Mechanize.new
    @word_for_search = word_for_search
  end


  def run
    base_url = "http://tw.dictionary.yahoo.com/dictionary?p="

    page = @mechanize.get("#{base_url}#{@word_for_search}")

    @result_doc = page.search(".result_cluster_first")
  end

  def success?
    @result_doc.present?
  end

  def exactly_hit?
    @word_for_search == word
  end

  def word
    @result_doc.search(".yschttl").text
  end

  def explanation
    @result_doc.search(".explanation").first.text
  end

end