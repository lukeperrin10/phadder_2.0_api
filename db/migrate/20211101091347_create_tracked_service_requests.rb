class CreateTrackedServiceRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :tracked_service_requests do |t|
      t.references :service_provider, foreign_key: true
      t.references :service_request, foreign_key: true
      t.references :creator, index: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
