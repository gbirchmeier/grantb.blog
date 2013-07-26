Feature: Posts crud

Background:
  Given the following users:
  | username | password |
  | goose    | topgun   |

  Given the following posts:
  | author | headline | content | published_at      | created_at        | updated_at        |
  | goose  | abc_1    | x       | 20130722 16:04:34 | 20130722 16:04:34 | 20130722 16:04:34 |
  | goose  | nuh uh   | x       |                   | 20050505 05:05:05 | 20070707 07:07:07 |
  | goose  | xyz_3    | x       | 19790309 16:04:34 | 19790309 16:04:34 | 19790309 16:04:34 |
  | goose  | foo_2    | x       | 20000501 16:04:34 | 20000501 16:04:34 | 20000501 16:04:34 |
  | goose  | nope     | x       |                   | 20060606 06:06:06 | 20060606 06:06:06 |

Scenario Outline: Anyone can see that the posts index shows the
                  published headlines, most-recently-published first.
  Given I am logged in as "<user>" with "<password>"
    And I visit "posts"
   Then I should see the following posts:
        | Headline |
        | abc_1    |
        | foo_2    |
        | xyz_3    |
  Examples:
        | user  | password |
        | goose | topgun   |
        |       |          |

Scenario: A rando can not see the draft posts
  Given I am not logged in
    And I visit "posts/drafts"
   Then I should see the not-allowed page

Scenario: I can see the draft posts, most-recently-updated first
  Given I am logged in as "goose" with "topgun"
    And I visit "posts/drafts"
   Then I should see the following draft posts:
        | Headline | Updated                 | Created                 |
        | nuh uh   | 2007-07-07 07:07:07 UTC | 2005-05-05 05:05:05 UTC |
        | nope     | 2006-06-06 06:06:06 UTC | 2006-06-06 06:06:06 UTC |

@wip
Scenario: I can create and publish a new post.
  Given I visit "posts/new"
   When I fill in "Headline" with "This is the new one"
    And I press "Publish"
   Then I should see a creation notice
    And I should be at the show page for post "This is the new one"
    And I should see "This is the new one"
   When I visit "posts"
   Then I should see the following posts:
        | headline |
        | This is the new one |
        | abc_1    |
        | foo_2    |
        | xyz_3    |


