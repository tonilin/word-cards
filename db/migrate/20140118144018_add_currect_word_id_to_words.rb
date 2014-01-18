class AddCurrectWordIdToWords < ActiveRecord::Migration
  def change
    add_column :words, :currect_word_id, :integer
  end
end
