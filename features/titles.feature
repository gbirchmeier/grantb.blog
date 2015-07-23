Feature: Pages have titles

Background:
  Given the following users:
        | username | password |
        | goose    | topgun   |
  Given the following posts:
        | author | headline | nice_url | content | published_at      | created_at        | updated_at        |
        | goose  | Duh Doy  | duh_doy  | x       | 20130722 16:04:34 | 20130722 16:04:34 | 20130722 16:04:34 |

Scenario Outline: Public pages have titles
  Given I visit "<url>"
   Then the html title should be "<title>"
  Examples:
        | url            | title                     |
        | /              | GrantB.net                |
        | /posts         | GrantB.net: Posts Archive |
        | /posts/duh_doy | GrantB.net: Duh Doy       |
        | /posts/invalid | GrantB.net: Invalid Page  |
        | /tags          | GrantB.net: All Tags      |
        | /tags/wang     | GrantB.net: Posts tagged "wang" |
        | /sign/in       | GrantB.net: Sign In       |


Scenario Outline: Admin pages have titles
  Given I am logged in as "goose" with "topgun"
    And I visit "<url>"
   Then the html title should be "<title>"
  Examples:
        | url          | title                          |
        | /admin       | GrantB.net Admin               |
        | /admin/posts | GrantB.net Admin: Posts index  |
        | /admin/users | GrantB.net Admin: Users index  |

