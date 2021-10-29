class AddCreatorToDeals < ActiveRecord::Migration[6.1]
  def change
    add_reference :deals, :creator, index: true, foreign_key: { to_table: :users }
  end
end
