note
	description: "[
				Data objects may have three possible properties:
					- name   (REQUIRED)
					- value  (OPTIONAL)
					- prompt (OPTIONAL)
			]"
	date: "$Date$"
	revision: "$Revision$"
	example: "[
		{
		  "prompt" : STRING_32,
		  "name" : STRING_32,
		  "value" : STRING_32
		  
		}
	]"

class
	CJ_DATA

create
	make,
	make_with_name

feature {NONE} -- Initialization

	make
		do
			make_with_name (create {like name}.make_empty)
		end

	make_with_name (a_name: like name)
		do
			name := a_name
		end

feature -- Access

	name: STRING_32

	prompt: detachable STRING_32

	value: detachable STRING_32
			-- this propertie May contain
			-- one of the following data types, STRING, NUMBER, Boolean(true,false), null

feature -- Access Extension

	files: detachable STRING_TABLE[STRING]
			-- A key, value pair of attached files
			-- this property is optional.

	acceptable_values: detachable ANY
			-- list of key, a list of value pairs, or a URL

	acceptable_url: detachable READABLE_STRING_32
			-- Acceptable value as a URL, if any.
		do
			if attached {READABLE_STRING_32} acceptable_values as l_val then
				Result := l_val
			end
		end

	acceptable_list: detachable LIST[READABLE_STRING_32]
			-- Acceptable value as a list, if any.
		do
			if attached {LIST[READABLE_STRING_32]} acceptable_values as l_val then
				Result := l_val
			end
		end

	acceptable_map: detachable STRING_TABLE[READABLE_STRING_32]
			-- Acceptable value as a list, if any.
		do
			if attached {STRING_TABLE[READABLE_STRING_32]} acceptable_values as l_val then
				Result := l_val
			end
		end

feature -- Element Change

	set_name (a_name: like name)
			-- Set `name' to `a_name'.
		do
			name := a_name
		ensure
			name_set: name ~ a_name
		end

	set_prompt (a_prompt: like prompt)
			-- Set `prompt' to `a_prompt'.	
		do
			prompt := a_prompt
		ensure
			prompt_set: prompt ~ a_prompt
		end

	set_value (a_value: like value)
		do
			value := a_value
		ensure
			value_set: value ~ a_value
		end

	add_attachment (a_key: READABLE_STRING_32; a_content: READABLE_STRING_32)
		local
			l_files: like files
		do
			l_files := files
			if l_files = Void then
				create l_files.make(0)
				files := l_files
			end
			l_files.force (a_content, a_key)
		end

	set_acceptable_url (a_url: READABLE_STRING_32)
			--Set `acceptable_values as a URL'
		do
			acceptable_values := a_url
		ensure
			acceptable_values_set: acceptable_values = a_url
		end

	set_acceptable_list (a_list: LIST[READABLE_STRING_32])
			-- Set `acceptable_values' as a list of keys
		do
			acceptable_values := a_list
		ensure
			acceptable_values_set: acceptable_values = a_list
		end

	set_acceptable_map (a_map: STRING_TABLE[READABLE_STRING_32])
			-- Set `acceptable_values' as a map of key value pairs
		do
			acceptable_values := a_map
		ensure
			acceptable_values_set: acceptable_values = a_map
		end


note
	copyright: "2011-2014, Javier Velilla, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
