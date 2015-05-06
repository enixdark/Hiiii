class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :name
      t.integer :parent_id
      t.string :controller
      t.string :action
      t.string :display_order

      t.timestamps null: false
    end
  end
end
