class AddScraperToWebSource < ActiveRecord::Migration[5.2]
  def change
    add_column :web_sources, :scraper, :string
  end
end
