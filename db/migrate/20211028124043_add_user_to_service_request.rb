class AddUserToServiceRequest < ActiveRecord::Migration[6.1]
  def change
    add_reference :service_requests, :user, foreign_key: true
  end
end
