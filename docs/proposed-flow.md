# Harvets 2 Jira
## A (mostly sane) method for keeping Jira estimated/used hour tracking in sync with Harvest

### Discoveries
* Harvest provides a fairly straightforward API as you might expect for a no-frills time-keeping system.
* Jira provides much more robust API functionality, being a much more complicated project management system.
* While Jira provides ticket meta-data, it appears to be Jira-only meta-data, not an arbitrary "dangle this value here" type of thing.
* Lack of arbitrary meta-data in Jira basically means we need to persist data about what we added to Jira, and how.

### Challenges
Were we simply to push Harvest time entries associated with Jira tickets into Jira, this could be a very simple "pipe" gluing the two services together.
While we need to know which entries we've added to Jira, the greatest complexity comes from the fact that a user can edit their Harvest time entries.  
So a possible scenario where a naive "pipe" approach would fall down might be like:

* A Jira ticket has 10 hours estimated.
* A user logs 6 hours against that ticket in Harvest.
* Our system sees the new 6 hour entry, applies it to the time spent in Jira, leaving a balance of 4 hours left on the ticket.
* The user subsequently revises their Harvest time entry to 3 hours.
* Now we have 3 hours actually logged in Harvest, 6 hours logged in Jira, and an outstanding time balance in Jira of 4 hours, instead of what ought to be 7 hours remaining.

If we simply pump new Harvest entries into Jira we're left wondering where the extra hours in Jira came from (they didn't; but we don't have an easy way to tell that).

### Proposed Solution
* For each user:
	* Pull all Harvest time entries for current period (1 month?) that can be correlated with a Jira ticket.
	* Check all of these Harvest time entries against our data store to see if they were:
		* Already added to Jira
		* and, Whether they were added to Jira with the same number of hours.
	* If unrecorded in Jira:
		* Add a new time entry to the Jira ticket
		* Track that we've performed this action by storing:
			* The user
			* The Jira ticket number
			* The number of hours entered
			* The original, corresponding Harvest time entry ID
			* The new, Jira time entry ID
	* If recorded in Jira, but with a different number of hours:
		* Update the Jira ticket to reflect the correct number of hours logged.
		* Ammend our data store record to reflect the new, corrected number of hours logged.

### Concerns
* How to handle Harvest entry deletions after logging to Jira?  If we log an entry, it's deleted, and then subsequently pull user time entries, while that change is, from our standpoint, an ammended time entry, we don't know about it, because we don't get a "zeroed" entry in the Harvest feed.  Do we need to then run against our local data store periodically (every run?) to ensure that all Harvest time entry IDs in our data store correspond to extant entries, and if not, process as though it were an ammended (to zero hours) entry?