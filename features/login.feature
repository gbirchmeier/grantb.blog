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
   Then I should see that I am logged in

Scenario: I can logout
  Given I log in as "goose" with "topgun"
    And I visit "/"
   Then I should see that I am logged in
   When I log out
   Then I should see a logout notice
    And I visit "/"
   Then I should see that no one is logged in

Scenario: If I'm logged in, the login form should say so
  Given I log in as "goose" with "topgun"
    And I visit the logon page
   # I'll get redirected
   Then I should be at the root path

