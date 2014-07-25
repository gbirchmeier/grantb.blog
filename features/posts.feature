Feature: Public post views

Background:
  Given the following users:
  | username | password |
  | goose    | topgun   |

  Given the following posts:
  | author | headline | content | published_at      | created_at        | updated_at        | nice_url |
  | goose  | abc_1    | batman  | 20130722 16:04:34 | 20130722 16:04:34 | 20130722 16:04:34 | be_nice  |
  | goose  | nuh uh   | x       |                   | 20050505 05:05:05 | 20070707 07:07:07 |          |
  | goose  | xyz_3    | x       | 19790309 16:04:34 | 19790309 16:04:34 | 19790309 16:04:34 |          |
  | goose  | foo_2    | x       | 20000501 16:04:34 | 20000501 16:04:34 | 20000501 16:04:34 |          |
  | goose  | nope     | x       |                   | 20060606 06:06:06 | 20060606 06:06:06 |          |


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

Scenario: Can see post via the nice_url
   When I visit "/posts/be_nice"
   Then I should see "batman"



