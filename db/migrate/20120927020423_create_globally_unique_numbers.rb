class CreateGloballyUniqueNumbers < ActiveRecord::Migration
  def change
    create_table :globally_unique_numbers do |t|
      t.integer :last_value
    end
  end
end
