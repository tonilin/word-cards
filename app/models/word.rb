# == Schema Information
#
# Table name: words
#
#  id          :integer          not null, primary key
#  word        :string(255)
#  explanation :string(255)
#  status      :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Word < ActiveRecord::Base


  has_many :user_words, :dependent => :destroy
  has_many :users, :through => :user_words

  scope :recent, -> {order("id desc")}

  validates :word, :uniqueness => true

end
