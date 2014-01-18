module ApplicationHelper

  def capitalize_first_char(str)
    str.slice(0,1).capitalize + str.slice(1..-1) if str
  end

end
