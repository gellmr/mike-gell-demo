Given /^I click (.*)$/ do | link |
  click_on link # links or buttons
end

Given /^I add Some Product (.*) to cart by clicking (.*) times$/ do | product_id, qty |
  within("div.parentalDiv-#{product_id}") do
    qty.to_i.times do
      find("button#qty-btn-plus-#{product_id}").click
      wait_for_ajax
    end
  end
end

Given /I should be on the store page/ do
  expect(page).to have_content("Available Products")
  expect(page).to have_content("Search")
  expect(page).to have_content("Go To Cart")
end

Given /I should be on the cart page/ do
  expect(page).to have_content("My Cart - 0 Lines")
  expect(page).to have_content("Back To Store")
  expect(page).to have_content("Clear My Cart")
  expect(page).to have_content("Total Items")
  expect(page).to have_content("Grand Total")
end