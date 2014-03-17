Given /^I should see (.*)$/ do | page_text |
  expect(page).to have_content(page_text)
end

Given /^There should be (.*) store lines$/ do | number |
  for n in 1..number.to_i
    expect(page).to have_content("Some Product #{n}")
  end
end