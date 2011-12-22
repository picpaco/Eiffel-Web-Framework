note
	description: "Summary description for {ROLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ROLE

feature -- Access

	description: STRING
			-- The description of `Current'.

feature -- Status report

feature -- Status setting

feature -- Basic operations

	submit_bug (a_bug: BUG)
			-- Submit a bug report.
		deferred
		end

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end
