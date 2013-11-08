class AddOrderValueToComponentAssignments < ActiveRecord::Migration
  def change
    add_column :component_assignments, :order_value, :integer
  end
end
