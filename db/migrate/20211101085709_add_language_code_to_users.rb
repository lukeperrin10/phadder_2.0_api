class AddLanguageCodeToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :language_code, :string
  end
end
