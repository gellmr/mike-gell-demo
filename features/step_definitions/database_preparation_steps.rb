


Given /^The store has three items$/ do
  # DatabaseCleaner.clean

  FactoryGirl.create(:product)
  FactoryGirl.create(:product)
  FactoryGirl.create(:product)

  expect(Product.all.count).to eq(3)
end