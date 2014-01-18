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
  include AASM

  has_many :user_words, :dependent => :destroy
  has_many :users, :through => :user_words

  scope :recent, -> {order("id desc")}

  validates :word, :presence => true, :uniqueness => true


  aasm :column => :status do
    state :pending, :initial => true
    state :success
    state :fail

    event :success do
      transitions :to => :success, :from => [:pending]
    end
    event :fail do
      transitions :to => :fail, :from => [:pending]
    end

  end



end
