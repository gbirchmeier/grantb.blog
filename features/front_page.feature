Feature: Basic front page features

Background:
  Given the following users:
        | username | password |
        | goose    | topgun   |

Scenario Outline: Show the front page
  Given I am logged in as "<user>" with "<password>"
   When I visit "/"
   Then I should see an element "#site_content"
  Examples:
        | user  | password |
        | goose | topgun   |
        |       |          |

Scenario Outline: See "no posts" notice when no posts
  Given I am logged in as "<user>" with "<password>"
   When I visit "/"
   Then I should see an element "#no_posts"
  Examples:
        | user  | password |
        | goose | topgun   |
        |       |          |

Scenario Outline: See the most-recently-published post if there are published posts
  Given I am logged in as "<user>" with "<password>"
    And the following posts:
        | author | headline | content | published_at      | created_at        | updated_at        |
        | goose  | abc_1    | x       | 20130722 16:04:34 | 20130722 16:04:34 | 20130722 16:04:34 |
   When I visit "/"
   Then I should see "abc_1"
  Examples:
        | user  | password |
        | goose | topgun   |
        |       |          |

Scenario: If logged in, I see the userbox
  Given I am logged in as "goose" with "topgun"
   When I visit "/"
   Then I should see an element "#userbox"

Scenario: If not logged in, I won't see the userbox
  Given I am not logged in
   When I visit "/"
   Then I should not see an element "#userbox"


