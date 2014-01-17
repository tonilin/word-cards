# == Schema Information
#
# Table name: user_words
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  word_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class UserWord < ActiveRecord::Base

  belongs_to :user
  belongs_to :word

  
end
