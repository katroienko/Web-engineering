db.orders_Roienko.insertMany([
  { id: 1, customer: "Olga",  product: "Apple",  amount: 15.55, city: "Berlin" },
  { id: 2, customer: "Anna",  product: "Apple",  amount: 10.05, city: "Madrid" },
  { id: 3, customer: "Olga",  product: "Kiwi",   amount: 9.6,   city: "Berlin" },
  { id: 4, customer: "Anton", product: "Apple",  amount: 20,    city: "Roma" },
  { id: 5, customer: "Olga",  product: "Banana", amount: 8,     city: "Madrid" },
  { id: 6, customer: "Petr",  product: "Orange", amount: 18.3,  city: "Paris" }
]);


1. Сколько всего было совершено покупок
{
    $count: "total_orders"
  }


2. Сколько всего раз были куплены яблоки
{
    $match: { product: "Apple" }
  },
  {
    $count: "apple_orders"
  }


  3. Вывести идентификаторы трех самых дорогих покупок
  {
    $sort: { amount: -1 }
  },
  {
    $limit: 3
  },
  {
    $project: {
      _id: 0,
      id: 1
    }
  }

  4. Сколько всего покупок было совершено в Берлине
  {
    $match: { city: "Berlin" }
  },
  {
    $count: "berlin_orders"
  }

  5. Количество покупок яблок в городах Берлин и Мадрид
  {
    $match: {
      product: "Apple",
      city: { $in: ["Berlin", "Madrid"] }
    }
  },
  {
    $count: "apple_orders_berlin_madrid"
  }

  6. Сколько было потрачено каждым покупателем
  {
    $group: {
      _id: "$customer",
      total: { $sum: "$amount" }
    }
  }

  7. В каких городах совершала покупки Ольга
  {
    $match: { customer: "Olga" }
  },
  {
    $group: {
      _id: "$city"
    }
  }