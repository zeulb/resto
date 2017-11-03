require 'database_cleaner'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

Token.create(token: '7c3959f341c12cc05499ede976fcb4ce')

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
    feedback: nil,
    items: [
      { meal_index: 0, quantity: 1, unit_price: 930, feedback: nil },
      { meal_index: 1, quantity: 2, unit_price: 870, feedback: nil }
    ]
  },
  {
    id: "GO124",
    serving_datetime: DateTime.now.advance(:hours => +2, :minutes => +10),
    feedback: { rating: 1, comment: "pretty good" },
    items: [
      { meal_index: 3, quantity: 1, unit_price: 680, feedback: { rating: 1, comment: "nice" } },
      { meal_index: 9, quantity: 3, unit_price: 795, feedback: { rating: -1, comment: "nooo" } },
      { meal_index: 8, quantity: 1, unit_price: 860, feedback: { rating: 1, comment: "ok!" } }
    ]
  },
  {
    id: "GO125",
    serving_datetime: DateTime.now.advance(:hours => +3, :minutes => +30),
    feedback: { rating: -1, comment: "average" },
    items: [
      { meal_index: 8, quantity: 7, unit_price: 795, feedback: { rating: -1, comment: "too oily" } }
    ]
  },
  {
    id: "GO126",
    serving_datetime: DateTime.now.advance(:hours => +5, :minutes => +24),
    feedback: nil,
    items: [
      { meal_index: 0, quantity: 1, unit_price: 920, feedback: nil },
      { meal_index: 2, quantity: 1, unit_price: 870, feedback: nil },
      { meal_index: 5, quantity: 1, unit_price: 770, feedback: nil },
      { meal_index: 6, quantity: 3, unit_price: 720, feedback: nil },
      { meal_index: 9, quantity: 1, unit_price: 1170, feedback: nil }
    ]
  },
  {
    id: "GO173",
    serving_datetime: DateTime.now.advance(:hours => +4, :minutes => +25),
    feedback: { rating: 1, comment: "superb" },
    items: [
      { meal_index: 7, quantity: 1, unit_price: 570, feedback: { rating: 1, comment: "" } },
      { meal_index: 4, quantity: 1, unit_price: 970, feedback: { rating: 1, comment: "" } },
      { meal_index: 8, quantity: 3, unit_price: 835, feedback: { rating: 1, comment: "" } },
      { meal_index: 6, quantity: 1, unit_price: 580, feedback: { rating: 1, comment: "+999" } }
    ]
  },
  {
    id: "GO175",
    serving_datetime: DateTime.now.advance(:hours => +4, :minutes => +35),
    feedback: nil,
    items: [
      { meal_index: 7, quantity: 1, unit_price: 570, feedback: nil }
    ]
  }
].map { | order |
  delivery_feedback = order[:feedback].nil? \
    ? nil \
    : Feedback.create(order[:feedback]);
  delivery_order = DeliveryOrder.create(
    order_id: order[:id],
    serving_datetime: order[:serving_datetime],
    feedback: delivery_feedback
  )

  order[:items].map { |item|
    meal = meals[item[:meal_index]]

    order_feedback = item[:feedback].nil? \
      ? nil \
      : Feedback.create(item[:feedback]);
    order_item = OrderItem.create(
      delivery_order: delivery_order,
      meal: meal,
      quantity: item[:quantity],
      unit_price: item[:unit_price],
      feedback: order_feedback
    )
  }
}
