class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :word
  belongs_to :explanation


end
