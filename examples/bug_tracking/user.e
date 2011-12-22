note
	description: "Summary description for {USER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	USER

create
	make

feature {NONE} -- Initialization

	make (a_role: ROLE; an_id: STRING)
			-- Initialization for `Current'.
		do
			role := a_role
			identity := an_id
		ensure
			role_set: role = a_role
			identity_set: identity = an_id
		end

feature -- Access

	role: ROLE
			-- The role of `Current'.

	identity: STRING
			-- The identity of 'Current'.

feature -- Status report

feature -- Status setting

	set_bug_status (a_bug: BUG; a_status: INTEGER_32)
			-- Set `a_bug' status.
		do
			if attached {ADMIN_USER} role as admin then
				admin.set_bug_status (a_bug, a_status)
			end
		end


feature -- Miscellaneous

feature -- Basic operations

	submit_bug (a_bug: BUG)
			-- Submit `a_bug' report.
		do
			role.submit_bug (a_bug)
		end

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end
