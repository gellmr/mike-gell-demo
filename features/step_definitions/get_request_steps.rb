Given /^I visit the (.*)$/ do | page_name |
  path = ''
  case page_name
    when 'home page'
      path = ''
  end
  visit "http://localhost:3000/#{path}"
end