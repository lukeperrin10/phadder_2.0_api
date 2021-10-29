class AddStateToServiceRequests < ActiveRecord::Migration[6.1]
  def change
    add_column :service_requests, :state, :string
  end
end
