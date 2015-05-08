class CreateMenunames < ActiveRecord::Migration
  def change
    create_table :menunames do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
