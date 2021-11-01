class AddNoteToBids < ActiveRecord::Migration[6.1]
  def change
    add_column :bids, :note, :text
  end
end
