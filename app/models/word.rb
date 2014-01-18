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

  has_many :explanations, :dependent => :destroy
  has_many :cards, :dependent => :destroy


  scope :recent, -> {order("id desc")}

  validates :content, :presence => true, :uniqueness => true

  after_create :crawl_yahoo_dic

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


  def crawl_yahoo_dic
    YahooDicCrawler.new(self).run if self.pending?
  end


end
