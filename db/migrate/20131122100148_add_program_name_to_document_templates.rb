class AddProgramNameToDocumentTemplates < ActiveRecord::Migration
  def change
    add_column :document_templates, :program_name, :string
  end
end
