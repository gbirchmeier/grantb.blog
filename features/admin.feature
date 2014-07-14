Feature: Admin menu page

Background:

Scenario: If logged in, I see the admin page
  Given the following users:
        | username | password |
        | goose    | topgun   |   
    And I am logged in as "goose" with "topgun"
   When I visit "/admin" 
   Then I should see an element "body.adminbody"

Scenario: If not logged in, I won't see the admin page
   When I visit "/admin" 
   Then I should see the not-allowed page

