note
	description: "Summary description for {ADMIN_USER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ADMIN_USER

inherit

	ROLE

feature -- Basic Operations

	set_bug_status (a_bug: BUG; a_status: INTEGER)
			-- Set `a_status' for `a_bug'.
		require
			a_bug.is_consistent_status (a_status)
		do
			a_bug.set_status (a_status)
		ensure
			status_set: a_bug.status.is_equal (a_status)
		end

	submit_bug (a_bug: BUG)
			-- Submit a bug report.
		do
		end

end
