class Menuname < ActiveRecord::Base
  has_many :menus, foreign_key: :id
end
