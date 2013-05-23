Feature: Users can request vacations

Scenario: I fill in fields appropriately
	When I request a vacation:
	|	vacation_applicant			|	ahmad	|
	|	vacation_duration			|	1		|
	|	vacation_from				|	2		|
	|	vacation_to					|	3		|
	Then I should be on the requests page
	And I should see "Your Request was sent successfully"

Scenario: I don't fill in fields appropriately
	When I request a vacation:
	|	vacation_applicant			|	ahmad	|
	|	vacation_duration			|	1		|
	|	vacation_from				|	2		|
	Then I should be on the vacations page
	And I should see "Please fill in all fields"
	And the "vacation_applicant" field should contain "ahmad"