class AddAttributeToServiceRequests < ActiveRecord::Migration[6.1]
  def change
    add_column :service_requests, :budget, :integer
    add_column :service_requests, :time_frame, :integer
  end
end
