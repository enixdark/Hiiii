class Menu < ActiveRecord::Base
  belongs_to :menuname, foreign_key: :parent_id
  after_save :clear_cache
 
  def clear_cache
    $redis.del "menus"
  end
end
