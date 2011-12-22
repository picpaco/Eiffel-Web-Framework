note
	description: "bug_tracking application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit

	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Some basic tests for the business domain.
		local
			a_user: USER
			an_admin: USER
			a_bug: BUG
		do
				-- Create a basic user
			create a_user.make (create {BASIC_USER}, "albo@mail.com")
				-- Create an admin user
			create an_admin.make (create {ADMIN_USER}, "bembo@mail.com")
				-- Create a bug
			create a_bug.make (a_user, create {DATE_TIME}.make_now)
				-- Submit a bug
			a_user.submit_bug (a_bug)
				-- Submit a bug
			an_admin.submit_bug (a_bug)
				-- Change the status of a bug (only for admin)
			an_admin.set_bug_status (a_bug, {BUG_TRACKING_CONSTANTS}.Invalid)
		end

end
