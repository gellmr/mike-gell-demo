Given /^I should see (.*)$/ do | page_text |
  expect(page).to have_content(page_text)
end

# Store
Given /^There should be (.*) store lines$/ do | number |
  for n in 1..number.to_i

    within "div.row.well.product-#{n}" do
      
      # Should have product name
      expect(page).to have_content("Some Product #{n}")

      # Should have dropdown: remove from cart
      expect(page).to have_selector("button.dropdown-toggle span.caret")
    end

    within "div.parentalDiv-#{n}" do

      # Should have input field
      expect(page).to have_selector("input#qtyToOrder-productId-#{n}")

      # Input field should have value blank
      find("input#qtyToOrder-productId-#{n}").value.should eq("")

      # The in-cart icon should not be visible
      expect(page).not_to have_selector("div.inCartIcon img")
    end
  end
end

# Store
Given /^Product (.*) should have Qty To Order (.*)$/ do | product_id, qty |
  find("div.parentalDiv-#{product_id} input#qtyToOrder-productId-#{product_id}").value.should eq(qty)
end

# Store
Given /^Product (.*) should have Added To Cart Icon$/ do | product_id |
  expect(page).to have_selector("div.parentalDiv-#{product_id} div.inCartIcon img")
end

# StorePage -> Click To Add Items To Cart
Given /^Cart page should have (.*) lines with quantities (.*)$/ do | number, quantities |
  quantities = quantities.split(',')
  expect(page).to have_content("My Cart - #{number} Lines")
  for n in 1..number.to_i
    within "div.row.well.product-#{n}" do
      expect(page).to have_content("Some Product #{n}")
      expect(page).to have_content("Amazing Description")
      expect(page).to have_content("100 in stock")
      expect(page).to have_content("$ 1.0 each")

      within "div.parentalDiv-#{n}" do
        # Input field should have the correct quantity value
        qty = quantities[n-1].to_s # n is one-based... quantities is a zero based array.
        find("input#qtyToOrder-productId-#{n}").value.should eq( qty )
      end
    end
  end
end