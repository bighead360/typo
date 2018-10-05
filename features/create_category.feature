Feature: Create Category
  As an admin
  In order to gift my thoughts to the world
  I want to create a category

  Background:
    Given the blog is set up
    And I am logged into the admin panel

  Scenario: Create Category Successfully
    Given I am on the new category page
    When I fill in "category_name" with "food"
    And I fill in "category_keywords" with "seafood"
    And I fill in "category_permalink" with "food_link"
    And I fill in "category_description" with "food description"

    And I press "Save"
    Then I should see "food"
    Then I should see "seafood"
    Then I should see "food_link"
    Then I should see "food description"