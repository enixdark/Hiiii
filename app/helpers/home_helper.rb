module HomeHelper
	# use redis for menus cache
  def get_menus
    menus = $redis.get('menus')
	if menus.nil?
      menu = Hash.new
	  Menu.pluck(:parent_id).to_set.sort.each do |id|
	    menu[id] = Array.new Menu.where(parent_id: id)
	  end
	  $redis.set('menus',menu.sort.to_json)
	  $redis.expire("menus",120.minutes.to_i)
	  menus = menu.to_json
	end
	@menus = eval(JSON.load(menus.to_json))
	return @menus
  end

    # uncomment if not install redis
   #  def get_menus
   #  menu = Hash.new
	  # Menu.all.map(&:parent_id).to_set.each do |id|
	  #   menu[id] = Array.new Menu.where(parent_id: id)
   #    end
	  # menus = menu.to_json
	  # @menus = eval(JSON.load(menus.to_json))
	  # return @menus.sort
   #  end 
end
