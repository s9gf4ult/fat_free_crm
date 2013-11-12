class CreateDocumentTemplates < ActiveRecord::Migration
  def change
    create_table :document_templates do |t|
      t.string :name
      t.text :content_before
      t.text :content_after

      t.timestamps
    end
  end
end
