Given /^I click (.*)$/ do | link |
  click_on link # links or buttons
end

Given /I should be on the store page/ do
  expect(page).to have_content("Available Products")

  # Should see the search text input and button
  expect(page).to have_content("Search")
  
  # Should see the pagination at top

  # Should see the first three products in the test database.
  expect(page).to have_content("Qty to Order")

  # Should see the pagination at bottom

  # Should see the 'go to cart' button.
  expect(page).to have_content("Go To Cart")
end