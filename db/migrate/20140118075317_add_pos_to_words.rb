class AddPosToWords < ActiveRecord::Migration
  def change
    add_column :words, :pos, :string
  end
end
