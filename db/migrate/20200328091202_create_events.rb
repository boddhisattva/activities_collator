class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title, null: false, index: true
      t.datetime :start, null: false, index: true
      t.datetime :finish, null: false, index: true
      t.text :description
      t.text :url, null: false
      t.references :web_source, null: false, foreign_key: true

      t.timestamps
    end

    add_index :events, :url, unique: true
  end
end
