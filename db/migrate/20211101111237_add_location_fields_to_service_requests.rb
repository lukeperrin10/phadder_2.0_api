class AddLocationFieldsToServiceRequests < ActiveRecord::Migration[6.1]
  def change
    add_column :service_requests, :address, :string
    add_column :service_requests, :latitude, :float
    add_column :service_requests, :longitude, :float
  end
end
