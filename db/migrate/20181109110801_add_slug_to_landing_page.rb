class AddSlugToLandingPage < ActiveRecord::Migration[5.1]
  def change
    add_column :landing_pages, :slug, :string
    add_index :landing_pages, :slug, unique: true
  end
end
