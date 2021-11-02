class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.references :service_provider, foreign_key: true

      t.timestamps
    end
  end
end
