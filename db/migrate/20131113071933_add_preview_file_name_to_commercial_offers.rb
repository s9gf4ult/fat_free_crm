class AddPreviewFileNameToCommercialOffers < ActiveRecord::Migration
  def change
    add_column :commercial_offers, :preview_file_name, :string
  end
end
