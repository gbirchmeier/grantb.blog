@wip
Feature: Posts crud

Background:
  Given the following users:
  | username | password |
  | goose    | topgun   |

  Given the following posts:
  | author | headline | content | published_at      | created_at        | updated_at        |
  | goose  | abc_1    | batman  | 20130722 16:04:34 | 20130722 16:04:34 | 20130722 16:04:34 |
  | goose  | nuh uh   | x       |                   | 20050505 05:05:05 | 20070707 07:07:07 |
  | goose  | xyz_3    | x       | 19790309 16:04:34 | 19790309 16:04:34 | 19790309 16:04:34 |
  | goose  | foo_2    | x       | 20000501 16:04:34 | 20000501 16:04:34 | 20000501 16:04:34 |
  | goose  | nope     | x       |                   | 20060606 06:06:06 | 20060606 06:06:06 |


#==============
# Pages anyone can see
#==============

Scenario Outline: Anyone can see the posts index, which shows the
                  published headlines, most-recently-published first.
  Given I am logged in as "<user>" with "<password>"
   When I visit "posts"
   Then I should see the following posts:
        | Headline | Published               |
        | abc_1    | 2013-07-22 16:04:34 UTC |
        | foo_2    | 2000-05-01 16:04:34 UTC |
        | xyz_3    | 1979-03-09 16:04:34 UTC |
    And I should see a link to show post "abc_1"
    And I should not see a link to edit post "abc_1"
  Examples:
        | user  | password |
        | goose | topgun   |
        |       |          |

Scenario Outline: Anyone can see published posts
  Given I am logged in as "<user>" with "<password>"
   When I show post "abc_1"
   Then I should see "abc_1"
    And I should see "batman"
  Examples:
        | user  | password |
        | goose | topgun   |
        |       |          |


#==============
# Pages and features that randos can't see
#==============

Scenario Outline: A rando can not visit various post-admin pages 
  Given I am not logged in
   When I visit "<path>"
   Then I should see the not-allowed page
  Examples:
        | path                   |
        | /posts/new             |
        | /posts/admin           |

Scenario: A rando can not edit posts
  Given I am not logged in
   When I edit post "abc_1"
   Then I should see the not-allowed page

Scenario: A rando can not show unpublished posts
  Given I am not logged in
   When I show post "nuh uh"
   Then I should see the not-allowed page

Scenario: A rando can not see edit links on the index
  Given I am not logged in
   When I visit "posts"
   Then I should not see a link to edit post "abc_1"

#TODO - rename admin to admin_index

#TODO - show page - rando sees no link to edit or admin-index
#TODO - index page - rando sees no link to admin-index

#TODO - show page - admin sees link to edit
#TODO - index - admin sees link to admin-index


#==============
# Admin views and CRUD stuff
#==============

Scenario: The admin posts-index page puts drafts first (sorted by updated_at)
          then published posts (sorted by published_at)
  Given I am logged in as "goose" with "topgun"
   When I visit "posts/admin"
   Then I should see the following posts:
        | Headline | Published               | Updated                 | Created                 |
        | nuh uh   |                         | 2007-07-07 07:07:07 UTC | 2005-05-05 05:05:05 UTC |
        | nope     |                         | 2006-06-06 06:06:06 UTC | 2006-06-06 06:06:06 UTC |
        | abc_1    | 2013-07-22 16:04:34 UTC | 2013-07-22 16:04:34 UTC | 2013-07-22 16:04:34 UTC |
        | foo_2    | 2000-05-01 16:04:34 UTC | 2000-05-01 16:04:34 UTC | 2000-05-01 16:04:34 UTC |
        | xyz_3    | 1979-03-09 16:04:34 UTC | 1979-03-09 16:04:34 UTC | 1979-03-09 16:04:34 UTC |

Scenario: The admin posts-index has links to show and edit pages
  Given I am logged in as "goose" with "topgun"
   When I visit "posts/admin"
   Then I should see a link to show post "abc_1"
    And I should see a link to edit post "abc_1"

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

