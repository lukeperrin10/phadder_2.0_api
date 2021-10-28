class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :post_code
      t.string :city
      t.string :country
      t.float :latitude, precision: 16, scale: 6
      t.float :longitude, precision: 16, scale: 6
      t.references :service_provider, null: false, foreign_key: true

      t.timestamps
    end
  end
end
