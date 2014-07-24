Feature: Ensure randos can not see these pages

Background:
  Given the following users:
  | username | password |
  | goose    | topgun   |

  Given the following posts:
  | author | headline | content | published_at      | created_at        | updated_at        |
  | goose  | abc_1    | batman  | 20130722 16:04:34 | 20130722 16:04:34 | 20130722 16:04:34 |
  | goose  | nuh uh   | x       |                   | 20050505 05:05:05 | 20070707 07:07:07 |


Scenario Outline: A rando can not visit various admin pages 
  Given I am not logged in
   When I visit "<path>"
   Then I should see the not-allowed page
  Examples:
        | path                   |   
        | /admin                 | 
        | /admin/posts           |
        | /admin/posts/new       |
        | /admin/posts/admin     |

Scenario: A rando can not edit posts
  Given I am not logged in
   When I edit post "abc_1"
   Then I should see the not-allowed page

Scenario: A rando can not show unpublished posts
  Given I am not logged in
   When I show post "nuh uh"
   Then I should see the invalid-post message
