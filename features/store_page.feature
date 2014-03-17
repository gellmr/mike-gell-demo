Feature: StorePage
  In order to generate revenue
  Customers
  Should be able to use the store page

  Scenario: View Store Page
    Given The store has three items
      And I visit the store page
    Then There should be 3 store lines
      And I should see Available Products
      And I should see Search
      And I should see Go To Cart

  Scenario: Button - Go to Cart
    Given I visit the store page
      And I should see Go To Cart
    When I click Go To Cart
    Then I should be on the cart page

  Scenario: Click To Add Items To Cart
    Given The store has three items
      And I visit the store page
      And There should be 3 store lines
    When I add Some Product 1 to cart by clicking
      And Product 1 should have Qty To Order 1
      And Product 1 should have Added To Cart Icon
      And I click My Cart
    Then Cart page should have 1 line
