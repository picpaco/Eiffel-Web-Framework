note
	description: "Summary description for {WSF_APPLICATION_X_WWW_FORM_URLENCODED_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_APPLICATION_X_WWW_FORM_URLENCODED_HANDLER

inherit
	WSF_MIME_HANDLER

	WSF_MIME_HANDLER_HELPER

feature -- Status report

	valid_content_type (a_content_type: READABLE_STRING_8): BOOLEAN
		do
			Result := a_content_type.same_string ({HTTP_MIME_TYPES}.application_x_www_form_encoded)
		end

feature -- Execution

	handle (a_content_type: READABLE_STRING_8; a_content_length: NATURAL_64; req: WSF_REQUEST;
			a_vars: HASH_TABLE [WSF_VALUE, READABLE_STRING_32]; a_raw_data: detachable CELL [detachable STRING_8])
		local
			l_content: READABLE_STRING_8
			n, p, i, j: INTEGER
			s: READABLE_STRING_8
			l_name, l_value: READABLE_STRING_8
		do
			l_content := read_input_data (req.input, a_content_length)
			if a_raw_data /= Void then
				a_raw_data.replace (l_content)
			end
			n := l_content.count
			check n_same_as_content_length: n = a_content_length.to_integer_32 end  --| FIXME: truncated value
			if n > 0 then
				from
					p := 1
				until
					p = 0
				loop
					i := l_content.index_of ('&', p)
					if i = 0 then
						s := l_content.substring (p, n)
						p := 0
					else
						s := l_content.substring (p, i - 1)
						p := i + 1
					end
					if not s.is_empty then
						j := s.index_of ('=', 1)
						if j > 0 then
							l_name := s.substring (1, j - 1)
							l_value := s.substring (j + 1, s.count)
							add_value_to_table (l_name, l_value, a_vars)
						end
					end
				end
			end
		end

end
