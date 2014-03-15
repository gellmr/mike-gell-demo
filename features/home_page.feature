Feature: HomePage
  In order to find out about Fuzzy Bear
  As a customer
  I want to view the home page

  Scenario: View Home Page
    Given I visit the home page
    Then I should see Welcome
    And I should see This is a pretend online store
    And I should see you don't have to pay (and won't receive anything)

  Scenario: Button - Go to Store
    Given I visit the home page
    And I should see Go To Store
    When I click Go To Store
    Then I should see Available Products
    And I should see Search
    And I should see Qty to Order
    And I should see Go To Cart