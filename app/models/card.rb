class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :word
  belongs_to :explanation

  scope :recent, -> {order("id desc")}


end
