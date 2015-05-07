module HomeHelper
  def get_menus
    menus = $redis.get('menus')
	if menus.nil?
      menu = Hash.new
	  Menu.pluck(:parent_id).to_set.sort.each do |id|
	    menu[id] = Array.new Menu.where(parent_id: id)
	  end
	  $redis.set('menus',menu.to_json)
	  $redis.expire("menus",1.minutes.to_i)
	  menus = menu.to_json
	end
	@menus = eval(JSON.load(menus.to_json))
	return @menus.sort
  end
end
