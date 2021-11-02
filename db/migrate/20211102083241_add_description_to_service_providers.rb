class AddDescriptionToServiceProviders < ActiveRecord::Migration[6.1]
  def change
    add_column :service_providers, :description, :text
  end
end
