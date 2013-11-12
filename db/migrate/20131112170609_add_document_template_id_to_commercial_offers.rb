class AddDocumentTemplateIdToCommercialOffers < ActiveRecord::Migration
  def change
    add_column :commercial_offers, :document_template_id, :integer
  end
end
