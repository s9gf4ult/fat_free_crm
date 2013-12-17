class AddDefinitionsToCommercialOffers < ActiveRecord::Migration
  def change
    add_column :commercial_offers, :definitions, :text
  end
end
