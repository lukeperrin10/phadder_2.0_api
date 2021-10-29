class CreateBids < ActiveRecord::Migration[6.1]
  def change
    create_table :bids do |t|
      t.float :amount
      t.references :service_request, foreign_key: true
      t.references :creator, index: true,  foreign_key: {to_table: :users}
      t.references :service_provider, foreign_key: true

      t.timestamps
    end
  end
end
