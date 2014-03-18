
Given /^The store has (.*) items$/ do | n |
  n.to_i.times do
    FactoryGirl.create(:product)
  end
  expect(Product.all.count).to eq(n.to_i)
end