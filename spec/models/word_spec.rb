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

require 'spec_helper'

describe Word do
  pending "add some examples to (or delete) #{__FILE__}"
end
