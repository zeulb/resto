# Resto API

Resto API is a Ruby on Rails 5 application intended to work with PostgreSQL 9 and above.

## Installation

Clone the Git repo

```
git clone git@github.com:zeulb/resto.git
cd resto
```

Install the gem dependencies

```
bundle install
```

## Sandbox

### Setting Up

Resto is intended to be used with PostgreSQL.
Configure your database connection in `config/database.yml`

```
[...]
default: &default
[...]
  host: localhost
  username: resto-api
  password: ...
[...]
```

### Seeding

Run

```
rails db:seed
```

To seed database with some data.

### Running Server
Start the server

```
rails server
```

A server will be run in port 3000 by default.

## Running Tests
To run all tests

```
bundle exec rspec
```

# API

Resto API require authorization header when making a request

```
Authorization: Bearer <authorization_token>
```

To get an authorization token, run

```
rails generate_token
```

## GET /orders

Returns list of delivery orders.

### Example:
`GET /orders`

```
[
  {
    "order_id": "GO123",
    "delivery_date": "2017-10-20",
    "delivery_time": "11:00-11:30",
    "feedback_submitted": true,
    "order_items": [
        {
        "name": "Buffalo Chicken on Sweet Potato Mash and Celery Confit ",
        "quantity": 2,
        "total_price": 2390
    }
  ]
  }
]
```

## GET /orders/:id

Returns delivery order details.

### Example:
`GET /orders/GO123`

```
{
  "order_id": "GO123",
  "delivery_date": "2017-10-20",
  "delivery_time": "11:00-11:30",
  "feedback_submitted": true,
  "order_items": [
    {
      "name": "Buffalo Chicken on Sweet Potato Mash and Celery Confit ",
      "quantity": 2,
      "total_price": 2390
    }
  ]
}
```

## GET /orders/:id/feedbacks
`GET /orders/GO123/feedbacks`

```
[
  {
    "ratable_id": 123,
    "ratable_type": "DeliveryOrder",
    "rating": 1,
    "comment": "Delivery was prompt and rider was kind, but he forgot cutleries"
  },
  {
    "ratable_id": 1,
    "ratable_type": "OrderItem",
    "rating": -1,
    "comment": "The food portion was too little, was alittle hungry after"
  }
  {
    "ratable_id": 2,
    "ratable_type": "OrderItem",
    "rating": -1,
    "comment": "It was super tasty and I loved it"
  }
]
```

## POST /orders/:id/feedbacks

`POST /orders/GO123/feedbacks -H Content-Type: application/json`

Payload

```
[
  {
    "ratable_id": 123,
    "ratable_type": "DeliveryOrder",
    "rating": 1,
    "comment": "Delivery was prompt and rider was kind, but he forgot cutleries"
  },
  {
    "ratable_id": 1,
    "ratable_type": "OrderItem",
    "rating": -1,
    "comment": "The food portion was too little, was alittle hungry after"
  }
  {
    "ratable_id": 2,
    "ratable_type": "OrderItem",
    "rating": -1,
    "comment": "It was super tasty and I loved it"
  }
]
```

```
{ status: "OK" }
```