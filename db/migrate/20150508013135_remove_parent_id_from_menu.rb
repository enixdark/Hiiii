class RemoveParentIdFromMenu < ActiveRecord::Migration
  def change
  	remove_column :menus, :parent_id, :integer
  end
end
