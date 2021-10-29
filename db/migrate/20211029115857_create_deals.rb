class CreateDeals < ActiveRecord::Migration[6.1]
  def change
    create_table :deals do |t|
      t.references :bid, foreign_key: true
      t.references :service_request, foreign_key: true

      t.timestamps
    end
  end
end
