Feature: the first test

Background:

Scenario: Show the default page
  Given I visit "/"
   Then I should see "front page"
    And I should not see "error"

