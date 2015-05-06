from bs4 import BeautifulSoup
import json

with open('menus.json','w+') as f:
	with open('Fresh Studio Project - Admin Panel.html','r+') as data:
		json_data = {}
		html = data.read()
		soup = BeautifulSoup(html)
		get_data = soup.find('div',id='menu_nav').findAll('li',{'class':'upp'})
		parent_id = 1
		for data in get_data:
			name = data.find('p',{'class':'top_center'}).text
			json_data[name] = []
			order = 1
			if data.find('li'):
				for li in data.findAll('li'):
					_name = li.text
					_data = li.find('a').attrs['href'].split('/')
					_, _, _, _, controllers, action,_type = _data if len(_data) == 7 else _data + ['']
					json_data[name].append({
						'name':_name,
						'controllers':controllers,
						'action':action + '/' +_type,
						'display_order':order,
						'parent_id':parent_id
					})
					order = order + 1
			else:
				_name = data.text.strip()
				_data = data.find('a').attrs['href'].split('/')
		    	_, _, _, _, controllers, action,_type = _data if len(_data) == 7 else _data + ['']
		    	json_data[name].append({
						'name':_name,
						'controllers':controllers,
						'action':action + '/' +_type,
						'display_order':order,
						'parent_id':parent_id
				})
			parent_id = parent_id + 1

		f.write(json.dumps(json_data,indent=4))


