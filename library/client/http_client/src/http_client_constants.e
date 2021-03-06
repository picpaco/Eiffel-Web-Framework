note
	description: "Summary description for {HTTP_CLIENT_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_CLIENT_CONSTANTS

feature -- Auth type

	auth_type_id (a_auth_type_string: READABLE_STRING_8): INTEGER
		local
			s: STRING_8
		do
			create s.make_from_string (a_auth_type_string)
			s.to_lower
			if s.same_string_general ("basic") then
				Result := Auth_type_basic
			elseif s.same_string_general ("digest") then
				Result := Auth_type_digest
			elseif s.same_string_general ("any") then
				Result := Auth_type_any
			elseif s.same_string_general ("anysafe") then
				Result := Auth_type_anysafe
			elseif s.same_string_general ("none") then
				Result := Auth_type_none
			end
		end

	Auth_type_none: INTEGER = 0
	Auth_type_basic: INTEGER = 1
	Auth_type_digest: INTEGER = 2
	Auth_type_any: INTEGER = 3
	Auth_type_anysafe: INTEGER = 4

end
