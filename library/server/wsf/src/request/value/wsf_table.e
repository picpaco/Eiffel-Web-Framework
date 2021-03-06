note
	description: "[
			Table which can contain value indexed by a key
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_TABLE

inherit
	WSF_VALUE
		redefine
			as_string
		end

	ITERABLE [WSF_VALUE]

create
	make

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_8)
		do
			name := url_decoded_string (a_name)
			create values.make (5)
		end

feature -- Access

	name: READABLE_STRING_32
			-- Parameter name	

	first_value: detachable WSF_VALUE
			-- First value if any.
		do
			across
				values as c
			until
				Result /= Void
			loop
				Result := c.item
			end
		end

	first_key: detachable READABLE_STRING_32
		do
			across
				values as c
			until
				Result /= Void
			loop
				Result := c.key
			end
		end

	values: HASH_TABLE [WSF_VALUE, READABLE_STRING_32]

	value (k: READABLE_STRING_32): detachable WSF_VALUE
		do
			Result := values.item (k)
		end

	count: INTEGER
		do
			Result := values.count
		end

feature -- Status report

	is_string: BOOLEAN
			-- Is Current as a WSF_STRING representation?
		do
			if values.count = 1 and then attached first_value as fv then
				Result := fv.is_string
			end
		end

feature -- Conversion

	as_string: WSF_STRING
		do
			if values.count = 1 and then attached first_value as fv then
				Result := fv.as_string
			else
				Result := Precursor
			end
		end

feature -- Element change

	add_value (a_value: WSF_VALUE; k: READABLE_STRING_32)
		require
			same_name: a_value.name.same_string (name)
		do
			values.force (a_value, k)
		end

feature -- Traversing

	new_cursor: ITERATION_CURSOR [WSF_VALUE]
		do
			Result := values.new_cursor
		end

feature -- Helper

	string_representation: STRING_32
		do
			create Result.make_from_string ("{")
			if values.count = 1 and then attached first_key as fk then
				Result.append (fk + ": ")
				if attached value (fk) as fv then
					Result.append (fv.string_representation)
				else
					Result.append ("???")
				end
			else
				across
					values as c
				loop
					if Result.count > 1 then
						Result.append_character (',')
					end
					Result.append (c.key + ": ")
					Result.append (c.item.string_representation)
				end
			end
			Result.append_character ('}')
		end

feature -- Visitor

	process (vis: WSF_VALUE_VISITOR)
		do
			vis.process_table (Current)
		end

end
