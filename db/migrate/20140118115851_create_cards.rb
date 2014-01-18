class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :user_id
      t.integer :word_id
      t.integer :explanation_id
      t.timestamps
    end
  end
end
