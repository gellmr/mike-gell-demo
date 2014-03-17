# This will guess the Product class
FactoryGirl.define do

  factory :product do
    sequence(:name) { |n| "Some Product #{n}" }
    description 'Amazing Description'
    image_url 'arduinoUNO.jpg'
    unit_price 1.00
    cost_from_supplier 0.50
    quantity_in_stock 100
  end

end