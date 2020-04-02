class RemoveScraperFromWebSource < ActiveRecord::Migration[5.2]
  def change
    remove_column :web_sources, :scraper
  end
end
