class CreateWebSources < ActiveRecord::Migration[5.2]
  def change
    create_table :web_sources do |t|
      t.text :url, null: false
      t.string :name, null: false

      t.timestamps
    end

    add_index :web_sources, :url, unique: true
  end
end
