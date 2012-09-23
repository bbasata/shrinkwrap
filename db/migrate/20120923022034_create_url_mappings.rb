class CreateUrlMappings < ActiveRecord::Migration
  def change
    create_table :url_mappings do |t|
      t.string :long_url
      t.string :short_path

      t.timestamps
    end
  end
end
