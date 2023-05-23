@tweets
Feature: Tweets

  Scenario Outline: A user has tweets
    Given I login as a user <user>
    When I visit the my tweets page
    Then I see <tweet_count> tweets
    Examples:
      | user   | tweet_count |
      | @jbird | 20          |
      | @p     | 12          |
      | @zfy   | 3           |

  Scenario: Tweets can be deleted
    Given I have a user @jbird
    When I visit the my tweets page
    Then I see 20 tweets
    When I delete 3 tweets
    Then I see 17 tweets