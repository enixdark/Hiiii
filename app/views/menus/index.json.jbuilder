json.array!(@menus) do |menu|
  json.extract! menu, :id, :name, :parent_id, :controller, :action, :display_order
  json.url menu_url(menu, format: :json)
end
