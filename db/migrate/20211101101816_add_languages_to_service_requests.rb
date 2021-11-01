class AddLanguagesToServiceRequests < ActiveRecord::Migration[6.1]
  def change
    add_column :service_requests, :languages, :text, array: true, default: []
  end
end
