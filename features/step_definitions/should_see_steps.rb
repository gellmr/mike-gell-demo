Given /^I should see (.*)$/ do | page_text |
  expect(page).to have_content(page_text)
end

Given /^There should be (.*) store lines$/ do | number |
  for n in 1..number.to_i
    expect(page).to have_content("Some Product #{n}")
  end
end

# Cart
Given /^Product (.*) should have Qty To Order (.*)$/ do | product_id, qty |
  find("div.parentalDiv-#{product_id} input#qtyToOrder-productId-#{product_id}").value.should eq(qty)
end

Given /^Product (.*) should have Added To Cart Icon$/ do | product_id |
  expect(page).to have_selector("div.parentalDiv-#{product_id} div.inCartIcon img")
end

Given /^Cart page should have (.*) line$/ do | number |
  expect(page).to have_content("My Cart - #{number} Lines")
  for n in 1..number.to_i
    expect(page).to have_content("Some Product #{n}")
    expect(page).to have_content("Amazing Description")
    expect(page).to have_content("100 in stock")
    expect(page).to have_content("$ 1.0 each")
    expect(page).to have_content("Qty to Order")
  end
end