class CreateJoinTableCategoriesServiceProviders < ActiveRecord::Migration[6.1]
  def change
    create_join_table :categories, :service_providers do |t|
      # t.index [:category_id, :service_provider_id]
      # t.index [:service_provider_id, :category_id]
    end
  end
end
