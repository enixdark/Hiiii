module ObjectMenu
  def clear_cache
    $redis.del "menus"
  end
end