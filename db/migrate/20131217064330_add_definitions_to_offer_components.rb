class AddDefinitionsToOfferComponents < ActiveRecord::Migration
  def change
    add_column :offer_components, :definitions, :text
  end
end
