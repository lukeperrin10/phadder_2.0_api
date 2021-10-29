class AddServiceProviderToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :service_provider, foreign_key: true
  end
end
