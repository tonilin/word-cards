class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :word
      t.string :status
      t.timestamps
    end

    add_index :words, :word, :unique => true
  end
end
