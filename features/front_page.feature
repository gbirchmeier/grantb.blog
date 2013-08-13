Feature: Basic front page features

Background:

Scenario: Show the default page
   When I visit "/"
   Then I should see an element "#site_content"

Scenario: See "no posts" notice when no posts
   When I visit "/"
   Then I should see an element "#no_posts"

Scenario: See the most-recently-published post if there are published posts
  Given the following users:
        | username | password |
        | goose    | topgun   |
  Given the following posts:
        | author | headline | content | published_at      | created_at        | updated_at        |
        | goose  | abc_1    | x       | 20130722 16:04:34 | 20130722 16:04:34 | 20130722 16:04:34 |
   When I visit "/"
   Then I should see "abc_1"

Scenario: If logged in, I see the userbox
  Given the following users:
        | username | password |
        | goose    | topgun   |
    And I am logged in as "goose" with "topgun"
   When I visit "/"
   Then I should see an element "#userbox"

Scenario: If not logged in, I won't see the userbox
   When I visit "/"
   Then I should not see an element "#userbox"


