Feature: Merge Articles
  As an admin
  In order to gift my thoughts to the world
  I want to merge the article with another article

  Background:
    Given the blog is set up
    Given the following users exist
      |login|password|email|profile_id|name|state|
      |peter|12345|peter@gmail.com|2|peter|active|
      |marry|12345|marry@gmail.com|3|marry|active|

    Given the following articles exist
      |id|title|author|body|user_id|published|published_at|state|allow_comments|
      |3|peter's title|peter|peter is here|2|true|2018-10-3 22:10:33|published|true|
      |4|marry's title|marry|marry is here|3|true|2018-10-3 22:00:34|published|true|

    Given the following comments exist
      |author|body|article_id|published|status_confirmed|type|
      |john|comment for peter|3|true|true|Article|
      |john|comment for marry|4|true|true|Article|


  
  Scenario: A non-admin cannot merge articles
  	Given I am logged into the non-admin panel
  	And I am on edit article page with article id 3
  	Then I should see "peter is here"
  	Then I should not see "Merge Article"

  Scenario: When articles are merged, the merged article should contain the text of both previous articles.
  	Given I am logged into the admin panel
  	And I am on edit article page with article id 3
  	And I fill in "other_article_id" with "4"
  	And I press "Merge"
  	And I should see "peter is here"
  	And I should see "marry is here"

  Scenario: When articles are merged, the merged article should have one author (either one of the authors of the original article).
  	Given I am logged into the admin panel
  	And I am on edit article page with article id 3
  	And I fill in "other_article_id" with "4"
  	And I press "Merge"
  	And I am on the all articles page
  	Then I should see "peter" in table
  	Then I should not see "marry" in table

  Scenario: Comments on each of the two original articles need to all carry over and point to the new, merged article.
  	Given I am on the home page
  	And I should see "1 comment"
  	And I should not see "2 comments"
  	Then I am logged into the admin panel
  	And I am on edit article page with article id 3
  	And I fill in "other_article_id" with "4"
  	And I press "Merge"
  	And I am on the home page
  	And I should see "2 comments"
  	And I should not see "1 comment"



  Scenario: The title of the new article should be the title from either one of the merged articles.
  	Given I am on the home page
  	And I should see "peter's title"
  	And I should see "marry's title"
  	Then I am logged into the admin panel
  	And I am on edit article page with article id 3
  	And I fill in "other_article_id" with "4"
  	And I press "Merge"
  	And I am on the home page
  	And I should see "peter's title"
  	And I should not see "marry's title"
  	


