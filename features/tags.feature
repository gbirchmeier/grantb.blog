Feature: Tags page

Background:
  Given user "goose"


Scenario: Only published tags show up on the tags page
  Given the following posts:
        | author | headline | content | published_at      | created_at        | updated_at        | tags        |
        | goose  | abc_1    | batman  | 20130722 16:04:34 | 20130722 16:04:34 | 20130722 16:04:34 | tagshown    |
        | goose  | nuh uh   | joker   |                   | 20050505 05:05:05 | 20070707 07:07:07 | tagnotshown |
   When I visit "/tags" 
   Then I should see "tagshown"
    And I should not see "tagnotshown"

Scenario: Can't see unpublished posts in a tag index
  Given the following posts:
        | author | headline | content | published_at      | created_at        | updated_at        | tags |
        | goose  | abc_1    | batman  | 20130722 16:04:34 | 20130722 16:04:34 | 20130722 16:04:34 | woop |
        | goose  | nuh uh   | joker   |                   | 20050505 05:05:05 | 20070707 07:07:07 | woop |
   When I visit "/tags/woop" 
   Then I should see "abc_1"
    And I should not see "nuh uh"

Scenario: Unpublished tags and non-existent tags give an approprate (and same) message
  Given the following posts:
        | author | headline | content | published_at      | created_at        | updated_at        | tags  |
        | goose  | abc_1    | batman  |                   | 20130722 16:04:34 | 20130722 16:04:34 | wooop |
   When I visit "/tags/wooop" 
   Then I should see the no-posts-with-tag message
   When I visit "/tags/roflcopter" 
    And I should see the no-posts-with-tag message

