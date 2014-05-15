note
	description: "Summary description for {TEST_UTILS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_UTILS


feature -- Access

	new_data (name: STRING; value: STRING; prompt: STRING): CJ_DATA
		do
			create Result.make
			Result.set_name (name)
			Result.set_value (value)
			Result.set_prompt (prompt)
		end

	new_data_acceptable_url (name: STRING; value: STRING; a_url: READABLE_STRING_32; prompt: STRING): CJ_DATA
		do
			Result := new_data (name, value, prompt)
			Result.set_acceptable_url (a_url)

		end

	new_data_acceptable_list (name: STRING; value: STRING; a_list: LIST[READABLE_STRING_32]; prompt: STRING): CJ_DATA
		do
			Result := new_data (name, value, prompt)
			Result.set_acceptable_list (a_list)
		end

	new_data_acceptable_map (name: STRING; value: STRING; a_map: STRING_TABLE[READABLE_STRING_32]; prompt: STRING): CJ_DATA
		do
			Result := new_data (name, value, prompt)
			Result.set_acceptable_map (a_map)
		end


	new_data_with_attachments (name: STRING; value: STRING; prompt: STRING; a_attachments: STRING_TABLE[STRING]): CJ_DATA
		do
			Result := new_data (name, value, prompt)
			from
				a_attachments.start
			until
				a_attachments.after
			loop
				Result.add_attachment (a_attachments.key_for_iteration.as_string_32, a_attachments.item_for_iteration.as_string_32)
				a_attachments.forth
			end

		end


	new_link (href: STRING; rel: STRING; prompt: detachable STRING; name: detachable STRING; render: detachable STRING): CJ_LINK
		do
			create Result.make (href, rel)
			if attached name as l_name then
				Result.set_name (l_name)
			end
			if attached render as l_render then
				Result.set_render (l_render)
			end
			if attached prompt as l_prompt then
				Result.set_prompt (l_prompt)
			end
		end


	new_attachements: STRING_TABLE[STRING]
		do
			create Result.make(0)
			Result.put ("content", "file1.txt")
		end

	new_list: LIST[READABLE_STRING_32]
		do
			create {ARRAYED_LIST[READABLE_STRING_32]}Result.make (4)
			Result.force ("Open")
			Result.force ("Close")
			Result.force ("Pending")
			Result.force ("Won't Fix")
		end

	new_map: STRING_TABLE[READABLE_STRING_32]
		do
			create Result.make (4)
			Result.force ("Open", "1")
			Result.force ("Close", "2")
			Result.force ("Pending","3")
			Result.force ("Won't Fix","4")
		end


	pretty_string (j: JSON_VALUE): STRING_32
		local
			v: JSON_PRETTY_STRING_VISITOR
		do
			create Result.make_empty
			create v.make_custom (Result, 4, 2)
			j.accept (v)
		end

end
