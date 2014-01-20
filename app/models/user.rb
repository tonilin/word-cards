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
  extend OmniauthCallbacks

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :authorizations, :dependent => :destroy
  has_many :cards

  def bind_service(provider, uid, token)
    authorizations.create(:provider => provider , :uid => uid, :token => token)
  end

  def self.find_binding(provider, uid)
    Authorization.find_by_provider_and_uid(provider, uid)
  end

  def fb_id
    authorizations.find_by_provider("facebook").try(:uid)
  end

  def add_card!(word, explanation)
    if !added_card?(word)
      card = cards.build
      card.word = word
      card.explanation = explanation
      card.save
    else
      cards.find_by_word_id(word.id).touch
    end
  end

  def added_card?(word)
    return false if word.nil?

    cards.find_by_word_id(word.id).present?
  end


end
