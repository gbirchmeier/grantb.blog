Feature: Posts crud

Background:
  Given the following users:
  | username | password |
  | goose    | topgun   |

  Given the following posts:
  | author | headline | content | published_at      | created_at        | updated_at        | tags     |
  | goose  | abc_1    | batman  | 20130722 16:04:34 | 20130722 16:04:34 | 20130722 16:04:34 | red blue |
  | goose  | nuh uh   | joker   |                   | 20050505 05:05:05 | 20070707 07:07:07 | red blue |
  | goose  | xyz_3    | x       | 19790309 16:04:34 | 19790309 16:04:34 | 19790309 16:04:34 | red blue |
  | goose  | foo_2    | x       | 20000501 16:04:34 | 20000501 16:04:34 | 20000501 16:04:34 | red blue |
  | goose  | nope     | x       |                   | 20060606 06:06:06 | 20060606 06:06:06 | red blue |



#==============
# Admin views and CRUD stuff
#==============

Scenario: The admin posts-index page puts drafts first (sorted by updated_at)
          then published posts (sorted by published_at)
  Given I am logged in as "goose" with "topgun"
   When I visit "admin/posts"
   Then I should see the following posts:
        | Headline | Published    | Updated      | Created      |
        | nuh uh   |              | Jul 7, 2007  | May 5, 2005  |
        | nope     |              | Jun 6, 2006  | Jun 6, 2006  |
        | abc_1    | Jul 22, 2013 | Jul 22, 2013 | Jul 22, 2013 |
        | foo_2    | May 1, 2000  | May 1, 2000  | May 1, 2000  |
        | xyz_3    | Mar 9, 1979  | Mar 9, 1979  | Mar 9, 1979  |

Scenario: The admin posts-index page doesn't show an empty table if there are no posts
  Given I am logged in as "goose" with "topgun"
    And this test deletes all posts
   When I visit "admin/posts"
   Then I should see no posts table

Scenario: The admin posts-index has links to show and edit pages
  Given I am logged in as "goose" with "topgun"
   When I visit "admin/posts"
   Then I should see a link to admin-show post "abc_1"
    And I should see a link to edit post "abc_1"

Scenario: The new-post form should have "Published?" start as unchecked
  Given I am logged in as "goose" with "topgun"
   When I visit "admin/posts/new"
   Then "Published?" should be unchecked

Scenario: The update-post form for a published post should have "Published?" start as checked
  Given I am logged in as "goose" with "topgun"
   When I edit post "abc_1"
   Then "Published?" should be checked

Scenario: The update-post form for a draft post should have "Published?" start as unchecked
  Given I am logged in as "goose" with "topgun"
   When I edit post "nope"
   Then "Published?" should be unchecked

Scenario: I can see a post
  Given I am logged in as "goose" with "topgun"
   When I admin-show post "nuh uh"
   Then I should see "joker"
    And I should see "blue red"

Scenario: I can create a new published post from the creation form
  Given I am logged in as "goose" with "topgun"
   When I visit "admin/posts/new"
    And I fill in "Headline" with "The new one"
    And I fill in "Content" with "blah blah"
    And I fill in "Tags" with "foo bar"
    And I fill in "Nice url" with "the-new-one"
    And I check "Published?"
    And I press "Create Post"
   Then I should see a creation notice
    And I should be at the show page for post "The new one"
    And I should see "The new one"
    And the DB should have this post:
        | headline    | content   | published_at | user  | tags    |
        | The new one | blah blah | non-null     | goose | bar foo |

Scenario: I can create a new draft post from the creation form
  Given I am logged in as "goose" with "topgun"
   When I visit "admin/posts/new"
    And I fill in "Headline" with "The new one"
    And I fill in "Content" with "blah blah"
    And I fill in "Nice url" with "the-new-one"
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

Scenario: Existing Tags show up in the edit form
  Given I am logged in as "goose" with "topgun"
   When I edit post "abc_1"
   Then I should see that field "Tags" contains "blue red"

Scenario: I can change a post's tags
  Given I am logged in as "goose" with "topgun"
   When I edit post "abc_1"
    And I fill in "Tags" with "green purple"
    And I press "Update Post"
   Then I should see an update notice
    And I should be at the show page for post "abc_1"
    And the DB should have this post:
        | headline    | published_at | user  | tags         |
        | abc_1       | non-null     | goose | green purple |


