note
	description: "Summary description for {WGI_NINO_INPUT_STREAM}."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WGI_NINO_INPUT_STREAM

inherit
	WGI_INPUT_STREAM

create
	make

feature {NONE} -- Initialization

	make (a_source: like source)
		do
			create last_string.make_empty
			set_source (a_source)
		end

feature {WGI_NINO_CONNECTOR, WGI_SERVICE} -- Nino

	set_source (i: like source)
		do
			source := i
		end

	source: TCP_STREAM_SOCKET

feature -- Input

	read_character
			-- Read the next character in input stream.
			-- Make the result available in `last_character'.
		do
			if source.socket_ok then
				source.read_character
				last_character := source.last_character
			else
				last_character := '%U'
			end
		end

	read_string (nb: INTEGER)
		do
			last_string.wipe_out
			if source.socket_ok then
				source.read_stream_thread_aware (nb)
				last_string.append_string (source.last_string)
			end
		end

feature -- Access

	last_string: STRING_8
			-- Last string read
			-- (Note: this query always return the same object.
			-- Therefore a clone should be used if the result
			-- is to be kept beyond the next call to this feature.
			-- However `last_string' is not shared between input objects.)

	last_character: CHARACTER_8
			-- Last item read

feature -- Status report

	is_open_read: BOOLEAN
			-- Can items be read from input stream?
		do
			Result := source.is_open_read
		end

	end_of_input: BOOLEAN
			-- Has the end of input stream been reached?
		do
			Result := source.ready_for_reading
		end

;note
	copyright: "2011-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
