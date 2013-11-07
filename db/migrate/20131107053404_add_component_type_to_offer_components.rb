class AddComponentTypeToOfferComponents < ActiveRecord::Migration
  def change
    add_column :offer_components, :component_type, :string
  end
end
