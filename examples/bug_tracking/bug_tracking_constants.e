note
	description: "Summary description for {BUG_TRACKING_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BUG_TRACKING_CONSTANTS

feature

	New, Delayed, Assigned, Fixed, Not_reproducible, Re_opened, Closed, Invalid,
	-- Statuses in a bug life cycle:
	-- Delayed: reason for delay explained in bug description.
	-- Assigned: a developer took it in charge for fixing.
	-- Fixed: bug fixed and test written for it.
	-- Not_reproducible: unable to reproduce. Reason explained in bug description.
	-- Re-opened: reason for re-opening explained in bug description.
	-- Closed: reason for closing explained in bug description.
	-- Invalid: inadequate bug description.
 Show_stopper, High, Medium, Low: INTEGER = unique
	-- Severity of bugs:
	-- Show_stopper: causes the application to crash unrecoverably. Major functionality affected.
	-- High: may cause application to crash. No workaround found. Major functionality affected.
	-- Medium: Workaround found. Major or minor functionality affected.
	-- Low: cosmetics, enhancement.

end
