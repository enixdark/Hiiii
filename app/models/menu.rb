class Menu < ActiveRecord::Base
  include ObjectMenu
  belongs_to :menuname, foreign_key: :parent_id
  after_save :clear_cache
  validates :name,  presence: true
  validates :parent_id,  presence: true
  validates :controller,  presence: true
  validates :action,  presence: true
  validates :display_order, :numericality => {:only_integer => true}
  
end
