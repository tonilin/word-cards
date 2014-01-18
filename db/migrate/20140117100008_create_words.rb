class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :content
      t.string :status
      t.timestamps
    end

    add_index :words, :content, :unique => true
  end
end
