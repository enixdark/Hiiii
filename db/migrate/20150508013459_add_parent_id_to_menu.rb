class AddParentIdToMenu < ActiveRecord::Migration
  def change
    add_column :menus, :parent_id, :integer
    add_foreign_key :menus, :menunames, column: :parent_id
  end
end
