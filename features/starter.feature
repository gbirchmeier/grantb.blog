Feature: the first test

Background:

Scenario: Show the default page
  Given I visit "/"
   Then I should see an element "#site_content"

