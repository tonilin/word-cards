# == Schema Information
#
# Table name: cards
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  word_id        :integer
#  explanation_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

require 'spec_helper'

describe Card do
  pending "add some examples to (or delete) #{__FILE__}"
end
