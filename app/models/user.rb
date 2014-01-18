# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :cards


  def add_card!(word, explanation)
    if !added_card?(word, explanation)
      card = cards.build
      card.word = word
      card.explanation = explanation
      card.save
    else
      cards.find_by_word_id_and_explanation_id(word.id, explanation.id).touch
    end
  end

  def added_card?(word, explanation)
    return false if word.nil? || explanation.nil?

    cards.find_by_word_id_and_explanation_id(word.id, explanation.id).present?
  end


end
