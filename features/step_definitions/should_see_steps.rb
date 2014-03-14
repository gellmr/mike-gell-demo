Given /^I should see (.*)$/ do | page_text |
  expect(page).to have_content(page_text)
end