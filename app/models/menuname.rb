class Menuname < ActiveRecord::Base
  include ObjectMenu
  validates :name,  presence: true
  has_many :menus, foreign_key: :parent_id
  before_save :clear_cache

  before_destroy :destroy_menu_all

  private
   def destroy_menu_all
     self.menus.delete_all   
   end
end
