# db/seeds.rb

# Beverage Types
water = BeverageType.create!(name: "Water-Based Beverages", category: "water")
coffee = BeverageType.create!(name: "Coffee-Based Beverages", category: "coffee")
tea = BeverageType.create!(name: "Tea-Based Beverages", category: "tea")
juice = BeverageType.create!(name: "Juice & Smoothies", category: "juice")
dairy = BeverageType.create!(name: "Dairy-Based Beverages", category: "dairy")
plant_milk = BeverageType.create!(name: "Plant-Based Milks", category: "plant_milk")
fermented = BeverageType.create!(name: "Fermented & Probiotic Beverages", category: "fermented")
carbonated = BeverageType.create!(name: "Carbonated & Artificially Sweetened Drinks", category: "carbonated")
alcoholic = BeverageType.create!(name: "Alcoholic Beverages", category: "alcoholic")

# Water-Based Subtypes
BeverageSubtype.create!([
  { name: "Plain Water", beverage_type: water },
  { name: "Infused Water (Lemon, Cucumber, Mint, Ginger)", beverage_type: water },
  { name: "Coconut Water", beverage_type: water },
  { name: "Electrolyte-Infused Water", beverage_type: water },
  { name: "Oral Rehydration Solutions", beverage_type: water }
])

# Coffee-Based Subtypes
BeverageSubtype.create!([
  { name: "Black Coffee", beverage_type: coffee },
  { name: "Espresso", beverage_type: coffee },
  { name: "Americano", beverage_type: coffee },
  { name: "Cold Brew", beverage_type: coffee },
  { name: "Latte (Dairy-Based)", beverage_type: coffee },
  { name: "Latte (Plant-Based)", beverage_type: coffee },
  { name: "Cappuccino", beverage_type: coffee },
  { name: "Mocha", beverage_type: coffee }
])

# Tea-Based Subtypes
BeverageSubtype.create!([
  { name: "Green Tea", beverage_type: tea },
  { name: "Black Tea", beverage_type: tea },
  { name: "White Tea", beverage_type: tea },
  { name: "Oolong Tea", beverage_type: tea },
  { name: "Herbal Tea (Peppermint, Chamomile, Ginger, Fennel, Licorice Root)", beverage_type: tea },
  { name: "Matcha", beverage_type: tea },
  { name: "Yerba Mate", beverage_type: tea }
])

# Juice & Smoothies Subtypes
BeverageSubtype.create!([
  { name: "Fresh Fruit Juice (Apple, Orange, Pomegranate, etc.)", beverage_type: juice },
  { name: "Vegetable Juice (Carrot, Beet, Celery, etc.)", beverage_type: juice },
  { name: "Blended Smoothies (Fruit-Based)", beverage_type: juice },
  { name: "Blended Smoothies (Vegetable-Based)", beverage_type: juice }
])

# Dairy-Based Beverages Subtypes
BeverageSubtype.create!([
  { name: "Whole Milk", beverage_type: dairy },
  { name: "Low-Fat Milk", beverage_type: dairy },
  { name: "Skim Milk", beverage_type: dairy },
  { name: "Lactose-Free Milk", beverage_type: dairy },
  { name: "Kefir", beverage_type: dairy },
  { name: "Buttermilk", beverage_type: dairy }
])

# Plant-Based Milks Subtypes
BeverageSubtype.create!([
  { name: "Almond Milk (Unsweetened)", beverage_type: plant_milk },
  { name: "Almond Milk (Sweetened)", beverage_type: plant_milk },
  { name: "Oat Milk (Unsweetened)", beverage_type: plant_milk },
  { name: "Oat Milk (Sweetened)", beverage_type: plant_milk },
  { name: "Soy Milk", beverage_type: plant_milk },
  { name: "Coconut Milk", beverage_type: plant_milk },
  { name: "Rice Milk", beverage_type: plant_milk },
  { name: "Hemp Milk", beverage_type: plant_milk }
])

# Fermented & Probiotic Beverages Subtypes
BeverageSubtype.create!([
  { name: "Kombucha", beverage_type: fermented },
  { name: "Lassi", beverage_type: fermented },
  { name: "Yakult", beverage_type: fermented },
  { name: "Kvass", beverage_type: fermented }
])

# Carbonated & Artificially Sweetened Drinks Subtypes
BeverageSubtype.create!([
  { name: "Regular Soda", beverage_type: carbonated },
  { name: "Diet Soda", beverage_type: carbonated },
  { name: "Sparkling Water", beverage_type: carbonated },
  { name: "Energy Drinks", beverage_type: carbonated },
  { name: "Sports Drinks (Gatorade, Powerade)", beverage_type: carbonated }
])

# Alcoholic Beverages Subtypes
BeverageSubtype.create!([
  { name: "Beer", beverage_type: alcoholic },
  { name: "Wine", beverage_type: alcoholic },
  { name: "Cider", beverage_type: alcoholic },
  { name: "Cocktails", beverage_type: alcoholic },
  { name: "Liquor (Vodka, Whiskey, Gin, Tequila)", beverage_type: alcoholic }
])

# Create standard additions
BeverageAddition::STANDARD_ADDITIONS.each do |name|
  BeverageAddition.find_or_create_by!(name: name)
end

# Create standard symptoms
Symptom::STANDARD_SYMPTOMS.each do |name|
  Symptom.find_or_create_by!(name: name)
end