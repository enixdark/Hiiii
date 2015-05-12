json.array!(@menunames) do |menuname|
  json.extract! menuname, :id
  json.url menuname_url(menuname, format: :json)
end
