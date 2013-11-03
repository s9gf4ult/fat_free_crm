class CreateComponentAssignments < ActiveRecord::Migration
  def change
    create_table :component_assignments do |t|
      t.integer :commercial_offer_id
      t.integer :offer_component_id

      t.timestamps
    end
  end
end
