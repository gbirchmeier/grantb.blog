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

Scenario: The new-post form should have "Published?" start as unchecked
  Given I am logged in as "goose" with "topgun"
   When I visit "posts/new"
   Then "Published?" should be unchecked

Scenario: The update-post form for a published post should have "Published?" start as checked
  Given I am logged in as "goose" with "topgun"
   When I edit post "abc_1"
   Then "Published?" should be checked

Scenario: The update-post form for a draft post should have "Published?" start as unchecked
  Given I am logged in as "goose" with "topgun"
   When I edit post "nope"
   Then "Published?" should be unchecked

Scenario: I can create a new published post from the creation form
  Given I am logged in as "goose" with "topgun"
   When I visit "posts/new"
    And I fill in "Headline" with "The new one"
    And I fill in "Content" with "blah blah"
    And I check "Published?"
    And I press "Create Post"
   Then I should see a creation notice
    And I should be at the show page for post "The new one"
    And I should see "The new one"
    And the DB should have this post:
        | headline    | content   | published_at | user  |
        | The new one | blah blah | non-null     | goose |

Scenario: I can create a new draft post from the creation form
  Given I am logged in as "goose" with "topgun"
   When I visit "posts/new"
    And I fill in "Headline" with "The new one"
    And I fill in "Content" with "blah blah"
    And I uncheck "Published?"
    And I press "Create Post"
   Then I should see a creation notice
    And I should be at the show page for post "The new one"
    And I should see "The new one"
    And the DB should have this post:
        | headline    | content   | published_at | user  |
        | The new one | blah blah |              | goose |

Scenario: I can update a draft post to be published
  Given I am logged in as "goose" with "topgun"
   When I edit post "nope"
    And I fill in "Headline" with "yep"
    And I check "Published?"
    And I press "Update Post"
   Then I should see an update notice
    And I should be at the show page for post "yep"
    And I should see "yep"
    And the DB should have this post:
        | headline    | published_at | user  |
        | yep         | non-null     | goose |
    And the DB should not have post "nope"

Scenario: I can update a draft post to be unpublished
  Given I am logged in as "goose" with "topgun"
   When I edit post "abc_1"
    And I fill in "Headline" with "ppppp"
    And I uncheck "Published?"
    And I press "Update Post"
   Then I should see an update notice
    And I should be at the show page for post "ppppp"
    And I should see "ppppp"
    And the DB should have this post:
        | headline    | published_at | user  |
        | ppppp       |              | goose |
    And the DB should not have post "abc_1"

