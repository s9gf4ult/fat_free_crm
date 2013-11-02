class CreateCommercialOffers < ActiveRecord::Migration
  def change
    create_table :commercial_offers do |t|
      t.string :name
      t.text :content
      t.integer :contact_id

      t.timestamps
    end
  end
end
