class Menu < ActiveRecord::Base
  include ObjectMenu
  belongs_to :menuname, foreign_key: :parent_id
  after_save :clear_cache
 
  
end
