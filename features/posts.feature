Feature: Public post views

Background:
  Given the following users:
  | username | password |
  | goose    | topgun   |

  Given the following posts:
  | author | headline | content | published_at      | created_at        | updated_at        | nice_url |
  | goose  | abc_1    | batman  | 20130722 16:04:34 | 20130722 16:04:34 | 20130722 16:04:34 | be_nice  |
  | goose  | nuh uh   | x       |                   | 20050505 05:05:05 | 20070707 07:07:07 | nuh_uh   |
  | goose  | xyz_3    | x       | 19790309 16:04:34 | 19790309 16:04:34 | 19790309 16:04:34 | xyz_3    |
  | goose  | foo_2    | x       | 20000501 16:04:34 | 20000501 16:04:34 | 20000501 16:04:34 | foo_2    |
  | goose  | nope     | x       |                   | 20060606 06:06:06 | 20060606 06:06:06 | nope     |


#==============
# Pages anyone can see
#==============

Scenario Outline: Anyone can see the posts index, which shows the
                  published headlines, most-recently-published first.
  Given I am logged in as "<user>" with "<password>"
   When I visit "posts"
   Then I should see the following items:
        | Headline | Published    |
        | abc_1    | Jul 22, 2013 |
        | foo_2    | May 1, 2000  |
        | xyz_3    | Mar 9, 1979  |
  Examples:
        | user  | password |
        | goose | topgun   |
        |       |          |


Scenario Outline: Can see post via the nice_url
  Given I am logged in as "<user>" with "<password>"
   When I visit "/posts/be_nice"
   Then I should see "abc_1"
   Then I should see "batman"
  Examples:
        | user  | password |
        | goose | topgun   |
        |       |          |


Scenario: Can't view posts using id-based urls
   When I visit an id-based url for post "abc_1"
   Then I should see the invalid-post message


