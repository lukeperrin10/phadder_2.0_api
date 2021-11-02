class AddVariantToServiceProviders < ActiveRecord::Migration[6.1]
  def change
    add_column :service_providers, :variant, :integer
  end
end
