Feature: StorePage
  In order to generate revenue
  Customers
  Should be able to use the store page

  Scenario: View Store Page
    Given The store has 3 items
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

  Scenario: Click To Add Item To Cart
    Given The store has 3 items
      And I visit the store page
    When I add Product 1 to cart by clicking 1 times
      And Product 1 should have Qty To Order 1
      And Product 1 should have Added To Cart Icon
      And I click My Cart
    Then Cart page should have 1 lines with quantities 1

  Scenario: Click To Add Multiple Items To Cart
    Given The store has 3 items
      And I visit the store page
    When I add Product 1 to cart by clicking 2 times
      And I add Product 2 to cart by clicking 4 times
      And Product 1 should have Qty To Order 2
      And Product 2 should have Qty To Order 4
      And Product 1 should have Added To Cart Icon
      And Product 2 should have Added To Cart Icon
      And I click My Cart
    Then Cart page should have 2 lines with quantities 2,4

  Scenario: Remove Item from Cart
    Given The store has 3 items
      And I visit the store page
      And I add Product 1 to cart by clicking 1 times
      And Product 1 should have Qty To Order 1
      And Product 1 should have Added To Cart Icon
    When I remove Product 1 from cart by clicking dropdown
    Then Product 1 should have Qty To Order 0
      And Product 1 should not have Added To Cart Icon

  # FAILS IN POLTERGEIST
  Scenario: Order too many items
    Given The store has 1 items
      And I visit the store page
    When I order 101 of Product 1 by typing
    Then Product 1 should complain Only 100 items available!
      And Product 1 should have Qty To Order 100

