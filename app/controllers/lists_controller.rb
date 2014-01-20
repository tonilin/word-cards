class ListsController < AuthenticatedController

  def index
    @word = Word.new

    @cards = current_user.cards.recent_update.all
  end


end
