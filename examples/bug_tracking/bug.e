note
	description: "Summary description for {BUG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BUG

inherit

	BUG_TRACKING_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make (a_reporter: USER; a_date_time_reported: DATE_TIME)
			-- Initialization for `Current'.
		do
			reporter := a_reporter
			date_time_reported := a_date_time_reported
			status := New
			create reproducing_instructions.make_empty
		ensure
			reporter_set: reporter = a_reporter
			date_time_reported_set: date_time_reported = a_date_time_reported
		end

feature -- Access

	reporter: USER
			-- Entity reporting `Current'.

	severity: INTEGER
			-- Severity of `Current' according to a scale described in {BUG_TRACKING_CONSTANTS}.

	status: INTEGER
			-- Status of `Current' according to a scale described in {BUG_TRACKING_CONSTANTS}.

	reproducing_instructions: STRING
			-- Instructions for reproducing the bug.

feature -- Measurement

feature -- Status report

	date_time_reported: DATE_TIME
			-- Date and time of reporting `Current'.

	is_consistent_status (a_status: INTEGER): BOOLEAN
			-- Is `a_status' a consistent status for `Current'?
		do
			Result := (status = New or status = Delayed or status = Assigned or status = Fixed or status = Not_reproducible or status = Re_opened or status = Closed or status = Invalid)
		end

	is_consistent_severity (a_severity: INTEGER): BOOLEAN
			-- Is `a_severity' a consistent severity for `Current'?
		do
			Result := (severity = Show_stopper or severity = High or severity = Medium or severity = Low)
		end

feature -- Status setting

	set_severity (a_severity: INTEGER)
			-- Set severity of `Current'.
		do
			severity := a_severity
		ensure
			severity_set: severity = a_severity
		end

	set_reproducing_instructions (a_reproducing_instructions: STRING)
			-- Set instructions for reproducing the bug.
		do
			reproducing_instructions := a_reproducing_instructions
		ensure
			reproducing_instructions_set: reproducing_instructions = a_reproducing_instructions
		end

feature {ADMIN_USER}

	set_status (a_status: INTEGER)
			-- Set status of `Current'.
		do
			status := a_status
		ensure
			status_set: status = a_status
		end

feature -- Miscellaneous

feature -- Basic operations

feature {NONE} -- Implementation

invariant
	severity_consistent: is_consistent_severity (severity)
	status_consistent: is_consistent_status (status)

end
