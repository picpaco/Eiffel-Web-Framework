note
	description: "Summary description for {REQUEST_ROUTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	REQUEST_ROUTER [H -> REQUEST_HANDLER [C], C -> REQUEST_HANDLER_CONTEXT]

feature -- Mapping

	map_default (h: like default_handler)
			-- Map default handler
			-- If no route/handler is found,
			-- then use `default_handler' as default if not Void
		do
			set_default_handler (h)
		end

	map (a_resource: READABLE_STRING_8; h: H)
			-- Map handler `h' with `a_resource'
		do
			map_with_request_methods (a_resource, h, Void)
		end

	map_routing (a_resource: READABLE_STRING_8; h: H)
			-- Map handler `h' with `a_resource'
		do
			map (a_resource, h)
		end

	map_with_request_methods (a_resource: READABLE_STRING_8; h: H; rqst_methods: detachable ARRAY [READABLE_STRING_8])
			-- Map handler `h' with `a_resource' and `rqst_methods'
		deferred
		end

	map_agent (a_resource: READABLE_STRING_8; a_action: PROCEDURE [ANY, TUPLE [ctx: C; req: WSF_REQUEST; res: WSF_RESPONSE]])
		do
			map_agent_with_request_methods (a_resource, a_action, Void)
		end

	map_agent_with_request_methods (a_resource: READABLE_STRING_8; a_action: PROCEDURE [ANY, TUPLE [ctx: C; req: WSF_REQUEST; res: WSF_RESPONSE]];
			 rqst_methods: detachable ARRAY [READABLE_STRING_8])
		local
			rah: REQUEST_AGENT_HANDLER [C]
		do
			create rah.make (a_action)
			if attached {H} rah as h then
				map_with_request_methods (a_resource, h, rqst_methods)
			else
				check valid_agent_handler: False end
			end
		end

feature -- Base url

	base_url: detachable READABLE_STRING_8
			-- Common start of any route url

	set_base_url (a_base_url: like base_url)
			-- Set `base_url' to `a_base_url'
		do
			base_url := a_base_url
		end

feature -- Execution

	dispatch (req: WSF_REQUEST; res: WSF_RESPONSE): BOOLEAN
			-- Dispatch `req, res' to the associated handler
			-- And return True is handled, otherwise False
		do
			Result := dispatch_and_return_handler (req, res) /= Void
		end

	dispatch_and_return_handler (req: WSF_REQUEST; res: WSF_RESPONSE): detachable H
			-- Dispatch `req, res' to the associated handler
			-- And return this handler
			-- If Result is Void, this means no handler was found.
		local
			d: like handler
			ctx: detachable like default_handler_context
		do
			d := handler (req)
			if d /= Void then
				Result := d.handler
				ctx := d.context
			else
				Result := default_handler
				if Result /= Void then
					ctx := default_handler_context (req)
				end
			end
			if Result /= Void and ctx /= Void then
				Result.execute (ctx, req, res)
			end
		ensure
			result_void_implie_no_default: Result = Void implies default_handler = Void
		end

feature -- Traversing

	new_cursor: ITERATION_CURSOR [TUPLE [handler: H; resource: READABLE_STRING_8; request_methods: detachable ARRAY [READABLE_STRING_8]]]
			-- Fresh cursor associated with current structure
		deferred
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Access: Implementation

	source_uri (req: WSF_REQUEST): READABLE_STRING_32
			-- URI to use to find handler.
		do
			Result := req.path_info
		end

	handler (req: WSF_REQUEST): detachable TUPLE [handler: H; context: like default_handler_context]
			-- Handler whose map matched with `req'
		require
			req_valid: source_uri (req) /= Void
		deferred
		ensure
			source_uri_unchanged: source_uri (req).same_string (old source_uri (req))
		end

	is_matching_request_methods (a_request_method: READABLE_STRING_GENERAL; rqst_methods: like formatted_request_methods): BOOLEAN
			-- `a_request_method' is matching `rqst_methods' contents
		local
			i,n: INTEGER
			m: READABLE_STRING_GENERAL
		do
			if rqst_methods /= Void and then not rqst_methods.is_empty then
				m := a_request_method
				from
					i := rqst_methods.lower
					n := rqst_methods.upper
				until
					i > n or Result
				loop
					Result := m.same_string (rqst_methods[i])
					i := i + 1
				end
			else
				Result := True
			end
		end

	formatted_request_methods (rqst_methods: like formatted_request_methods): detachable ARRAY [READABLE_STRING_8]
			-- Formatted request methods values
		local
			i,l,u: INTEGER
		do
			if rqst_methods /= Void and then not rqst_methods.is_empty then
				l := rqst_methods.lower
				u := rqst_methods.upper
				create Result.make_filled (rqst_methods[l], l, u)
				from
					i := l + 1
				until
					i > u
				loop
					Result[i] := rqst_methods[i].as_string_8.as_upper
					i := i + 1
				end
			end
		end

feature {NONE} -- Implementation

	set_default_handler (h: like default_handler)
			-- Set `default_handler' to `h'
		deferred
		ensure
			default_handler_set: h = default_handler
		end

	default_handler: detachable H
			-- Default handler
		deferred
		end

	default_handler_context (req: WSF_REQUEST): C
			-- Default handler context associated with `default_handler'
		require
			has_default_handler: default_handler /= Void
		deferred
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
