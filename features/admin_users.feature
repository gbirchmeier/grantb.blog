Feature: Users crud

Background:
  Given the following users:
  | username  | first_name | last_name | password |
  | blacklion | Keith      | Kogane    | lion1    |
  | redlion   | Lance      | McClain   | lion1    |


Scenario: Users index
  Given I am logged in as "blacklion" with "lion1"
   When I visit "admin/users"
   Then I should see the following items:
        | Username  | Last Name | First Name |
        | blacklion | Kogane    | Keith      |
        | redlion   | McClain   | Lance      |
    And I should see a link to admin-show user "blacklion"
    And I should see a link to edit user "blacklion"

Scenario: Show a user
  Given I am logged in as "blacklion" with "lion1"
   When I admin-show user "redlion"
   Then I should see "redlion"
    And I should see "Lance"


