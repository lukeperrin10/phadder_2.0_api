class AddLocationToServiceRequests < ActiveRecord::Migration[6.1]
  def change
    add_column :service_requests, :location, :string
  end
end
