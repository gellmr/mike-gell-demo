# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' },  { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel',  city: cities.first)

Product.create([{
    name: 'Wire - 8 x 2m lengths',
    unitPrice: 4.95,
    costFromSupplier: 3.10,
    quantityInStock: 30,
    description: 'Copper core: 0.12mm diameter.',
    imageUrl: 'wire.jpg'
  }, {
    name: 'Alligator to Alligator Cables',
    unitPrice: 3.77,
    costFromSupplier: 3.00,
    quantityInStock: 15,
    description: 'Each pack contains two cables: one red and one black.',
    imageUrl: 'alligator.png'
  }, {
    name: 'Cat-6 cable: Patch Cable',
    unitPrice: 2.49,
    costFromSupplier: 2.00,
    quantityInStock: 100,
    description: 'Up to 500 mhz. Uses 4 twisted pairs with PE divider.',
    imageUrl: 'cat-6_cable.jpeg'
  }, {
    name: 'Cat-6 cable: 3 meters',
    unitPrice: 3.77,
    costFromSupplier: 3.00,
    quantityInStock: 110,
    description: 'Up to 500 mhz. Uses 4 twisted pairs with PE divider.',
    imageUrl: 'cat-6_cable5feet.jpeg'
  }, {
    name: 'USB 2.0 Cable: A to B (3 meters)',
    unitPrice: 5.69,
    costFromSupplier: 4.50,
    quantityInStock: 75,
    description: 'USB 2.0 Cable (A to B) 10 feet',
    imageUrl: 'usbCable.jpeg'
  }, {
    name: 'Arduino UNO',
    unitPrice: 32.50,
    costFromSupplier: 27.50,
    quantityInStock: 42,
    description: 'Arduino is a microcontroller used for prototyping.
It has a USB port so you can connect to a PC and load programs.
The Arduino platform is open source,
and uses a simple IDE which can be be freely downloaded.',
    imageUrl: 'arduinoUNO.jpg'
  }, {
    name: 'Ethernet Pro DEV-10536',
    unitPrice: 56.00,
    costFromSupplier: 50.00,
    quantityInStock: 20,
    description: 'Arduino Pro Microcontroller with Ethernet Shield',
    imageUrl: 'ethernet_pro.jpg'
  }, {
    name: 'ARMmite Pro',
    unitPrice: 34.44,
    costFromSupplier: 27.50,
    quantityInStock: 12,
    description: 'ARM7 CPU running at 60MHz. Has 32K of Flash memory. Uses an Arduino Pro footprint.',
    imageUrl: 'ARM7.jpeg'
  }, {
    name: 'PRT-09567 Bread Board',
    unitPrice: 6.84,
    costFromSupplier: 5.00,
    quantityInStock: 40,
    description: 'Solderless Bread Board. Has 30 Columns and 10 Rows. Length: 83.5mm Width: 54.5mm Height: 8.5mm',
    imageUrl: 'breadboard.jpeg'
  }, {
    name: 'Capacitor: Electrolytic 1000uF 35V 105C L/ESR',
    unitPrice: 1.65,
    costFromSupplier: 1.02,
    quantityInStock: 350,
    description: 'Diameter: 16mm Length: 20mm Impedence: 0.035',
    imageUrl: 'CapacitorElectrolytic1000uF_35V_105C_LESR.jpg'
  }, {
    name: '270pF 50Volt Ceramic Capacitor',
    unitPrice: 0.32,
    costFromSupplier: 0.20,
    quantityInStock: 200,
    description: 'Lead Spacing: 5mm  (Pack of 2)',
    imageUrl: '270pF_50_VoltCeramicCapacitor.jpg'
  }, {
    name: '0.01uF/10nF 3kV Ceramic Capacitor',
    unitPrice: 2.50,
    costFromSupplier: 2.05,
    quantityInStock: 140,
    description: 'High Voltage',
    imageUrl: '3kVCeramicCapacitor.jpg'
  }, {
    name: 'LED 5mm Red Waterclear',
    unitPrice: 0.65,
    costFromSupplier: 0.45,
    quantityInStock: 120,
    description: '',
    imageUrl: 'LED_redWaterClear.jpg'
  }, {
    name: 'LED 5mm Red Diffuse',
    unitPrice: 0.20,
    costFromSupplier: 0.10,
    quantityInStock: 2000,
    description: '',
    imageUrl: 'LED_RedDiffuse.jpg'
  }, {
    name: 'PN200 PNP Transistor',
    unitPrice: 0.35,
    costFromSupplier: 0.22,
    quantityInStock: 340,
    description: 'A single PN200 PNP Transistor',
    imageUrl: 'transistor.jpeg'
  }, {
    name: '74LS155 IC Unit',
    unitPrice: 2.20,
    costFromSupplier: 1.45,
    quantityInStock: 320,
    description: 'Dual 1 of 4 Decoder / Multiplexer',
    imageUrl: 'dual_1to4_decoder.jpg'
  }, {
    name: '74LS138 IC Unit',
    unitPrice: 1.45,
    costFromSupplier: 0.90,
    quantityInStock: 240,
    description: '1 of 8 Decoder / Demultiplexer',
    imageUrl: '1to8_demuxIC.jpg'
  }, {
    name: 'Thermistor: NTC 5mm Dia,
    100 Ohm',
    unitPrice: 1.35,
    costFromSupplier: 1.05,
    quantityInStock: 230,
    description: 'Made of ceramic material which changes resistance according to temperature. Very reliable.',
    imageUrl: 'thermistor.png'
  }, {
    name: 'Mini Photocell SEN-09088',
    unitPrice: 1.67,
    costFromSupplier: 1.30,
    quantityInStock: 201,
    description: 'A photoconductive cell. Resistance varies according to the amount of light it is exposed to.',
    imageUrl: 'photocell.jpeg'
  }, {
    name: 'Metal Film Resistor Pack - 300 pieces',
    unitPrice: 14.95,
    costFromSupplier: 11.35,
    quantityInStock: 100,
    description: 'Five of virtually every resistance value from 10 Ohm to 1 Meg.',
    imageUrl: 'resistors300pk.jpg'
  }, {
    name: 'Carbon Film Resistor Pack - 300 pieces',
    unitPrice: 6.95,
    costFromSupplier: 4.95,
    quantityInStock: 210,
    description: 'Five of virtually every resistance value from 1 Ohm to 10 Meg.',
    imageUrl: 'carbonResistorPack300.png'
  }, {
    name: '500 Ohm 24mm Potentiometer',
    unitPrice: 2.25,
    costFromSupplier: 1.70,
    quantityInStock: 230,
    description: 'Full size - 24mm diameter. Power rating is 0.5W maximum.',
    imageUrl: 'pot.png'
  }, {
    name: '9T 4300KV Brushless Motor',
    unitPrice: 49.39,
    costFromSupplier: 29.30,
    quantityInStock: 210,
    description: 'Dimensions: 3.175mm shaft diameter. 36mm body diameter. 50mm can length. 66mm total length. Weight: 170g',
    imageUrl: 'brushlessMotor.jpeg'
  }, {
    name: 'Metal Gear Motor',
    unitPrice: 59.75,
    costFromSupplier: 26.30,
    quantityInStock: 190,
    description: '12V motor with a 100:1 metal gearbox',
    imageUrl: 'metalGearmotor.png'
  }, {
    name: 'Low Cost Digital Multimeter',
    unitPrice: 9.95,
    costFromSupplier: 5.00,
    quantityInStock: 130,
    description: 'Specifications:
DV Voltage { 200mV, 200mV, 20V, 200V, 1000V }
MaxInput: { 1000V DC -/+ 0.5 }
DC Amps: { 200 uA, 20mA, 200mA, 10A }
Overload Protected
AC Volts: { 200V, 750 V, maxinput 750V }
Resistance: { 200, 2k, 20k, 200k Ohms, 2M Ohms -/+ 1.2% }',
    imageUrl: 'multimeter.jpg'
  }, {
    name: 'Crimp Tool With Connectors',
    unitPrice: 13.95,
    costFromSupplier: 9.45,
    quantityInStock: 30,
    description: 'Comes with 80 of the most popular automotive connectors.',
    imageUrl: 'crimper.jpg'
  }, {
    name: 'Temperature Controller Soldering Station',
    unitPrice: 59.95,
    costFromSupplier: 72.30,
    quantityInStock: 45,
    description: 'Temperature range: 150-450 degrees Celsius. Power: 40W',
    imageUrl: 'solder.jpg'
  }, {
    name: 'Lead-Free Solder',
    unitPrice: 17.95,
    costFromSupplier: 12.30,
    quantityInStock: 40,
    description: '200g Roll. Wire Diameter: 1mm Composition: (Tin: 99.3% Copper: 0.7%)',
    imageUrl: 'solderWire.jpg'
  }, {
    name: 'PCB Holder with Magnifying Glass',
    unitPrice: 12.95,
    costFromSupplier: 9.95,
    quantityInStock: 40,
    description: 'Magnifying Glass: 90mm',
    imageUrl: 'pcbHolderWithMag.jpg'
  }, {
    name: '6 " Long Noser Pliers',
    unitPrice: 11.95,
    costFromSupplier: 7.50,
    quantityInStock: 30,
    description: 'With serrated jaws.',
    imageUrl: 'pliers.jpg'
  }
])