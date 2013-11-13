class AddPreviewFileNameToOfferComponents < ActiveRecord::Migration
  def change
    add_column :offer_components, :preview_file_name, :string
  end
end
