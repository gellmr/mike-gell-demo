Feature: StorePage
  In order to generate revenue
  Customers
  Should be able to use the store page

  Scenario: View Store Page
    Given I visit the store page
    Then I should see Available Products
      And I should see Search
      And I should see Go To Cart

  Scenario: Button - Go to Cart
    Given I visit the store page
      And I should see Go To Cart
    When I click Go To Cart
    Then I should be on the cart page