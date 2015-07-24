Feature: Public post views

Background:
  Given the following users:
  | username | password |
  | goose    | topgun   |


Scenario: Post index shows headlines, most-recently-published first
  Given the following posts:
        | author | headline | content | published_at      | created_at        | updated_at        | nice_url |
        | goose  | abc_1    | batman  | 20130722 16:04:34 | 20130722 16:04:34 | 20130722 16:04:34 | be_nice  |
        | goose  | nuh uh   | x       |                   | 20050505 05:05:05 | 20070707 07:07:07 | nuh_uh   |
        | goose  | xyz_3    | x       | 19790309 16:04:34 | 19790309 16:04:34 | 19790309 16:04:34 | xyz_3    |
   When I visit "posts"
   Then I should see the following items:
        | Headline | Published    |
        | abc_1    | Jul 22, 2013 |
        | xyz_3    | Mar 9, 1979  |


Scenario: Can see post via the nice_url
  Given the following posts:
        | author | headline | content | published_at      | created_at        | updated_at        | nice_url |
        | goose  | abc_1    | batman  | 20130722 16:04:34 | 20130722 16:04:34 | 20130722 16:04:34 | be_nice  |
   When I visit "/posts/be_nice"
   Then I should see "abc_1"
   Then I should see "batman"


Scenario: Can't view posts using id-based urls
  Given the following posts:
        | author | headline | content | published_at      | created_at        | updated_at        | nice_url |
        | goose  | abc_1    | batman  | 20130722 16:04:34 | 20130722 16:04:34 | 20130722 16:04:34 | be_nice  |
   When I visit the id-based url for post "abc_1"
   Then I should see the invalid-item message


Scenario: The posts index markdown-ifies the headlines
  Given the following posts:
        | author | headline       | content | published_at      | created_at        | updated_at        | nice_url |
        | goose  | uno *dos* tres | batman  | 20130722 16:04:34 | 20130722 16:04:34 | 20130722 16:04:34 | be_nice  |
   When I visit "/posts/be_nice"
   Then I should see "dos" is in italics


Scenario: Invalid post urls get an appropriate view
   When I visit "/posts/arglebargle"
   Then I should see the invalid-item message

