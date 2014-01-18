module CardsHelper

  def render_card_destroy_btn(card)
    button_link_to "Delete", card_path(card), :method => :delete, :class => "btn btn-default"
  end

end
