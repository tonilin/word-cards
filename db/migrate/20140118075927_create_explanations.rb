class CreateExplanations < ActiveRecord::Migration
  def change
    create_table :explanations do |t|
      t.string :pos
      t.string :content
      t.integer :word_id
      t.timestamps
    end
  end
end
