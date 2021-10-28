class CreateServiceRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :service_requests do |t|
      t.string :title
      t.text :details

      t.timestamps
    end
  end
end
