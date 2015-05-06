class CreateData 
	def self.execute filepath
		text = File.open(filepath).read
		data = eval text
		data.each do |key,data|
			# Menuname.create!(id: data[0][:parent_id], name: key)
		    data.each do |db|
				Menu.create!(parent_id: db[:parent_id], action: db[:action],
							controller: db[:controllers],
							name: db[:name], display_order: db[:display_order])
			end
		end
	end
end
