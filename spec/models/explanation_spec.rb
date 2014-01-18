# == Schema Information
#
# Table name: explanations
#
#  id         :integer          not null, primary key
#  pos        :string(255)
#  content    :string(255)
#  word_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Explanation do
  pending "add some examples to (or delete) #{__FILE__}"
end
