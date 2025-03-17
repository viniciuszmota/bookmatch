class CreateMatches < ActiveRecord::Migration[7.1]
  def change
    create_table :matches do |t|
      t.string :status
      t.references :requestee,  foreign_key: { to_table: :books } 
      t.references :attendee,  foreign_key: { to_table: :books }
      t.timestamps
    end
  end
end
