module ExplanationHelper

  def render_explanation_pos(explanation)
    explanation.pos if explanation
  end


  def render_explanation_content(explanation)
    explanation.content if explanation
  end

end
