class CreateJoinTableCategoriesServiceRequests < ActiveRecord::Migration[6.1]
  def change
    create_join_table :categories, :service_requests do |t|
      # t.index [:category_id, :service_request_id]
      # t.index [:service_request_id, :category_id]
    end
  end
end
