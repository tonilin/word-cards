# == Schema Information
#
# Table name: words
#
#  id              :integer          not null, primary key
#  content         :string(255)
#  status          :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  currect_word_id :integer
#

class Word < ActiveRecord::Base
  include AASM

  has_many :explanations, :dependent => :destroy
  has_many :cards, :dependent => :destroy
  belongs_to :currect_word, :foreign_key => :currect_word_id, :class_name => "Word"

  scope :recent, -> {order("id desc")}

  validates :content, :presence => true, :uniqueness => true

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
