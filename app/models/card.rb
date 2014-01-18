class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :word
  belongs_to :explanation

  scope :recent_update, -> {order("updated_at desc")}
  scope :without_explanation, -> {where("explanation_id IS NULL")}

end
