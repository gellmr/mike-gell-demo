# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' },  { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel',  city: cities.first)

Product.create([{
    name: 'Wire - 8 x 2m lengths',
    unit_price: 4.95,
    cost_from_supplier: 3.10,
    quantity_in_stock: 30,
    description: 'Copper core: 0.12mm diameter.',
    image_url: 'wire.jpg'
  }, {
    name: 'Alligator to Alligator Cables',
    unit_price: 3.77,
    cost_from_supplier: 3.00,
    quantity_in_stock: 15,
    description: 'Each pack contains two cables: one red and one black.',
    image_url: 'alligator.png'
  }, {
    name: 'Cat-6 cable: Patch Cable',
    unit_price: 2.49,
    cost_from_supplier: 2.00,
    quantity_in_stock: 100,
    description: 'Up to 500 mhz. Uses 4 twisted pairs with PE divider.',
    image_url: 'cat-6_cable.jpeg'
  }, {
    name: 'Cat-6 cable: 3 meters',
    unit_price: 3.77,
    cost_from_supplier: 3.00,
    quantity_in_stock: 110,
    description: 'Up to 500 mhz. Uses 4 twisted pairs with PE divider.',
    image_url: 'cat-6_cable5feet.jpeg'
  }, {
    name: 'USB 2.0 Cable: A to B (3 meters)',
    unit_price: 5.69,
    cost_from_supplier: 4.50,
    quantity_in_stock: 75,
    description: 'USB 2.0 Cable (A to B) 10 feet',
    image_url: 'usbCable.jpeg'
  }, {
    name: 'Arduino UNO',
    unit_price: 32.50,
    cost_from_supplier: 27.50,
    quantity_in_stock: 42,
    description: 'Arduino is a microcontroller used for prototyping.
It has a USB port so you can connect to a PC and load programs.
The Arduino platform is open source,
and uses a simple IDE which can be be freely downloaded.',
    image_url: 'arduinoUNO.jpg'
  }, {
    name: 'Ethernet Pro DEV-10536',
    unit_price: 56.00,
    cost_from_supplier: 50.00,
    quantity_in_stock: 20,
    description: 'Arduino Pro Microcontroller with Ethernet Shield',
    image_url: 'ethernet_pro.jpg'
  }, {
    name: 'ARMmite Pro',
    unit_price: 34.44,
    cost_from_supplier: 27.50,
    quantity_in_stock: 12,
    description: 'ARM7 CPU running at 60MHz. Has 32K of Flash memory. Uses an Arduino Pro footprint.',
    image_url: 'ARM7.jpeg'
  }, {
    name: 'PRT-09567 Bread Board',
    unit_price: 6.84,
    cost_from_supplier: 5.00,
    quantity_in_stock: 40,
    description: 'Solderless Bread Board. Has 30 Columns and 10 Rows. Length: 83.5mm Width: 54.5mm Height: 8.5mm',
    image_url: 'breadboard.jpeg'
  }, {
    name: 'Capacitor: Electrolytic 1000uF 35V 105C L/ESR',
    unit_price: 1.65,
    cost_from_supplier: 1.02,
    quantity_in_stock: 350,
    description: 'Diameter: 16mm Length: 20mm Impedence: 0.035',
    image_url: 'CapacitorElectrolytic1000uF_35V_105C_LESR.jpg'
  }, {
    name: '270pF 50Volt Ceramic Capacitor',
    unit_price: 0.32,
    cost_from_supplier: 0.20,
    quantity_in_stock: 200,
    description: 'Lead Spacing: 5mm  (Pack of 2)',
    image_url: '270pF_50_VoltCeramicCapacitor.jpg'
  }, {
    name: '0.01uF/10nF 3kV Ceramic Capacitor',
    unit_price: 2.50,
    cost_from_supplier: 2.05,
    quantity_in_stock: 140,
    description: 'High Voltage',
    image_url: '3kVCeramicCapacitor.jpg'
  }, {
    name: 'LED 5mm Red Waterclear',
    unit_price: 0.65,
    cost_from_supplier: 0.45,
    quantity_in_stock: 120,
    description: '',
    image_url: 'LED_redWaterClear.jpg'
  }, {
    name: 'LED 5mm Red Diffuse',
    unit_price: 0.20,
    cost_from_supplier: 0.10,
    quantity_in_stock: 2000,
    description: '',
    image_url: 'LED_RedDiffuse.jpg'
  }, {
    name: 'PN200 PNP Transistor',
    unit_price: 0.35,
    cost_from_supplier: 0.22,
    quantity_in_stock: 340,
    description: 'A single PN200 PNP Transistor',
    image_url: 'transistor.jpeg'
  }, {
    name: '74LS155 IC Unit',
    unit_price: 2.20,
    cost_from_supplier: 1.45,
    quantity_in_stock: 320,
    description: 'Dual 1 of 4 Decoder / Multiplexer',
    image_url: 'dual_1to4_decoder.jpg'
  }, {
    name: '74LS138 IC Unit',
    unit_price: 1.45,
    cost_from_supplier: 0.90,
    quantity_in_stock: 240,
    description: '1 of 8 Decoder / Demultiplexer',
    image_url: '1to8_demuxIC.jpg'
  }, {
    name: 'Thermistor: NTC 5mm Dia,
    100 Ohm',
    unit_price: 1.35,
    cost_from_supplier: 1.05,
    quantity_in_stock: 230,
    description: 'Made of ceramic material which changes resistance according to temperature. Very reliable.',
    image_url: 'thermistor.png'
  }, {
    name: 'Mini Photocell SEN-09088',
    unit_price: 1.67,
    cost_from_supplier: 1.30,
    quantity_in_stock: 201,
    description: 'A photoconductive cell. Resistance varies according to the amount of light it is exposed to.',
    image_url: 'photocell.jpeg'
  }, {
    name: 'Metal Film Resistor Pack - 300 pieces',
    unit_price: 14.95,
    cost_from_supplier: 11.35,
    quantity_in_stock: 100,
    description: 'Five of virtually every resistance value from 10 Ohm to 1 Meg.',
    image_url: 'resistors300pk.jpg'
  }, {
    name: 'Carbon Film Resistor Pack - 300 pieces',
    unit_price: 6.95,
    cost_from_supplier: 4.95,
    quantity_in_stock: 210,
    description: 'Five of virtually every resistance value from 1 Ohm to 10 Meg.',
    image_url: 'carbonResistorPack300.png'
  }, {
    name: '500 Ohm 24mm Potentiometer',
    unit_price: 2.25,
    cost_from_supplier: 1.70,
    quantity_in_stock: 230,
    description: 'Full size - 24mm diameter. Power rating is 0.5W maximum.',
    image_url: 'pot.png'
  }, {
    name: '9T 4300KV Brushless Motor',
    unit_price: 49.39,
    cost_from_supplier: 29.30,
    quantity_in_stock: 210,
    description: 'Dimensions: 3.175mm shaft diameter. 36mm body diameter. 50mm can length. 66mm total length. Weight: 170g',
    image_url: 'brushlessMotor.jpeg'
  }, {
    name: 'Metal Gear Motor',
    unit_price: 59.75,
    cost_from_supplier: 26.30,
    quantity_in_stock: 190,
    description: '12V motor with a 100:1 metal gearbox',
    image_url: 'metalGearmotor.png'
  }, {
    name: 'Low Cost Digital Multimeter',
    unit_price: 9.95,
    cost_from_supplier: 5.00,
    quantity_in_stock: 130,
    description: 'Specifications:
DV Voltage { 200mV, 200mV, 20V, 200V, 1000V }
MaxInput: { 1000V DC -/+ 0.5 }
DC Amps: { 200 uA, 20mA, 200mA, 10A }
Overload Protected
AC Volts: { 200V, 750 V, maxinput 750V }
Resistance: { 200, 2k, 20k, 200k Ohms, 2M Ohms -/+ 1.2% }',
    image_url: 'multimeter.jpg'
  }, {
    name: 'Crimp Tool With Connectors',
    unit_price: 13.95,
    cost_from_supplier: 9.45,
    quantity_in_stock: 30,
    description: 'Comes with 80 of the most popular automotive connectors.',
    image_url: 'crimper.jpg'
  }, {
    name: 'Temperature Controller Soldering Station',
    unit_price: 59.95,
    cost_from_supplier: 72.30,
    quantity_in_stock: 45,
    description: 'Temperature range: 150-450 degrees Celsius. Power: 40W',
    image_url: 'solder.jpg'
  }, {
    name: 'Lead-Free Solder',
    unit_price: 17.95,
    cost_from_supplier: 12.30,
    quantity_in_stock: 40,
    description: '200g Roll. Wire Diameter: 1mm Composition: (Tin: 99.3% Copper: 0.7%)',
    image_url: 'solderWire.jpg'
  }, {
    name: 'PCB Holder with Magnifying Glass',
    unit_price: 12.95,
    cost_from_supplier: 9.95,
    quantity_in_stock: 40,
    description: 'Magnifying Glass: 90mm',
    image_url: 'pcbHolderWithMag.jpg'
  }, {
    name: '6 " Long Noser Pliers',
    unit_price: 11.95,
    cost_from_supplier: 7.50,
    quantity_in_stock: 30,
    description: 'With serrated jaws.',
    image_url: 'pliers.jpg'
  }
])

# This seed script relies upon bash shell environment variables, 
# which are are NOT AVAILABLE because we are using foreman to load the .env file.
# Eg, the variables in .env are only available in the context of foreman.
# So if you try to call 'bundle exec rake db:seed' ...it will fail at User.create()
# The solution is to call db:seed, using 'foreman run ...'

# To recreate the database from scratch...
#               bundle exec rake db:drop
#               bundle exec rake db:create
#               bundle exec rake db:migrate
#   foreman run bundle exec rake db:seed

# The last step must be run using foreman,
# otherwise ENV['ADMIN_LOGIN'] will not be available
# and the User.create() command will fail.

User.create(
  email: "gellmr@gmail.com",
  first_name: "Mike",
  last_name: "Gell",
  password: ENV['ADMIN_LOGIN'],
  password_confirmation: ENV['ADMIN_LOGIN'],
  home_phone: '5555 5555',
  work_phone: '+614 5555 5555',
  mobile_phone: '+614 5555 5555'
)