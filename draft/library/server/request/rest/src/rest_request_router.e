note
	description: "Summary description for {REST_REQUEST_ROUTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	REST_REQUEST_ROUTER [H -> REST_REQUEST_HANDLER [C], C -> REST_REQUEST_HANDLER_CONTEXT]

inherit
	REQUEST_ROUTER [H, C]

;note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
