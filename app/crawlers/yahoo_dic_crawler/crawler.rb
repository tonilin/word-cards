class YahooDicCrawler::Crawler

  def initialize(word_for_search)
    @mechanize = Mechanize.new
    @word_for_search = word_for_search
  end


  def run
    base_url = "http://tw.dictionary.yahoo.com/dictionary?p="

    page = @mechanize.get("#{base_url}#{@word_for_search}")

    @result_doc = page.search(".result_cluster_first")

    self
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
    @result_doc.search(".explanation").first.try(:text)
  end

  def explanations
    result = []

    explanation_pos_wrappers = @result_doc.search(".explanation_pos_wrapper")

    explanation_pos_wrappers.each do |explanation_pos_wrapper|
      pos = explanation_pos_wrapper.search(".pos_abbr").first.try(:text)

      explanation_pos_wrapper.search(".explanation").each do |explanation_row|
        result << {
          pos: pos,
          content: explanation_row.try(:text)
        }
      end

    end

    result
  end

  def pos
    @result_doc.search(".explanation_group_hd .pos_abbr").first.text
  end

end