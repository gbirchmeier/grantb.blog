Feature: Login/logout

Background:
  Given the following users:
  | username | password |
  | goose    | topgun   |

Scenario: I can login
  Given I visit the logon page
   When I fill in "Username" with "goose"
    And I fill in "Password" with "topgun"
    And I click "Submit"
    And I visit "/"
   Then I should see "You are logged in"

Scenario: I can logout
  Given I am logged in as "goose" with "topgun"
    And I visit "/"
   Then I should see "You are logged in"
   When I log out
   Then I should see "You are logged out"
    And I visit "/"
   Then I should not see "You are logged in"

Scenario: If I'm logged in, the login form should say so
  Given I am logged in as "goose" with "topgun"
    And I visit the logon page
   Then I should see "You are already logged in"
    And I should not see a field for "Username"

