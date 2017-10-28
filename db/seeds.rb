require 'database_cleaner'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

meals = [
  {
    name: "Dragon Well Basil Rice",
    byline: "with herbal tea egg"
  },
  {
    name: "Grilled Farm Fresh Chicken",
    byline: "with pesto on organic mixed grains"
  },
  {
    name: "Roasted Summer Vegetables with King Oyster Mushroom",
    byline: "on barley, corn and couscous mix"
  },
  {
    name: "Pan‑seared Norwegian Salmon",
    byline: "with citrus vinaigrette on pasta"
  },
  {
    name: "Grilled Piri‑Piri Chicken",
    byline: "with cherry tomato and roasted olive"
  },
  {
    name: "Roasted Wild Mushrooms",
    byline: "with organic balsamic vinegar and sundried tomatoes"
  },
  {
    name: "Chocolate Banana Crumble Tart",
    byline: "with praline & caramel sauce"
  },
  {
    name: "Raspberry Frangipane",
    byline: "with almond flakes"
  },
  {
    name: "Slow‑Roasted Rendang Beef Short Rib",
    byline: "with charred cauliflower and tomato confit"
  },
  {
    name: "Duck Confit",
    byline: "with cranberry on cauliflower rice"
  }
].map { | meal | Meal.create(meal) }

orders = [
  {
    id: "GO123",
    serving_datetime: DateTime.now.advance(:hours => +4, :minutes => +20),
    items: [
      { meal_index: 0, quantity: 1, unit_price: 930 },
      { meal_index: 1, quantity: 2, unit_price: 870 }
    ]
  },
  {
    id: "GO124",
    serving_datetime: DateTime.now.advance(:hours => +2, :minutes => +10),
    items: [
      { meal_index: 3, quantity: 1, unit_price: 680 },
      { meal_index: 9, quantity: 3, unit_price: 795 },
      { meal_index: 8, quantity: 1, unit_price: 860 }
    ]
  },
  {
    id: "GO125",
    serving_datetime: DateTime.now.advance(:hours => +3, :minutes => +30),
    items: [
      { meal_index: 8, quantity: 7, unit_price: 795 }
    ]
  },
  {
    id: "GO126",
    serving_datetime: DateTime.now.advance(:hours => +5, :minutes => +24),
    items: [
      { meal_index: 0, quantity: 1, unit_price: 920 },
      { meal_index: 2, quantity: 1, unit_price: 870 },
      { meal_index: 5, quantity: 1, unit_price: 770 },
      { meal_index: 6, quantity: 3, unit_price: 720 },
      { meal_index: 9, quantity: 1, unit_price: 1170 }
    ]
  },
  {
    id: "GO173",
    serving_datetime: DateTime.now.advance(:hours => +4, :minutes => +25),
    items: [
      { meal_index: 7, quantity: 1, unit_price: 570 },
      { meal_index: 4, quantity: 1, unit_price: 970 },
      { meal_index: 8, quantity: 3, unit_price: 835 },
      { meal_index: 6, quantity: 1, unit_price: 580 }
    ]
  }
].map { | order |
  delivery_order = DeliveryOrder.create(
    order_id: order[:id],
    serving_datetime: order[:serving_datetime]
  )

  order[:items].map { |item|
    meal = meals[item[:meal_index]]

    order_item = OrderItem.create(
      delivery_order: delivery_order,
      meal: meal,
      quantity: item[:quantity],
      unit_price: item[:unit_price]
    )
  }
}
