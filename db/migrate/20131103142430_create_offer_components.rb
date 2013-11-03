class CreateOfferComponents < ActiveRecord::Migration
  def change
    create_table :offer_components do |t|
      t.string :name
      t.text :content

      t.timestamps
    end
  end
end
