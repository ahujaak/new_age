# README

#### Database Design:
![New Age DB design](https://user-images.githubusercontent.com/32529060/188628983-67358d84-df58-4642-b466-70e9f29d0502.png)


#### Configuration: 
* Ruby version
  2.7.2
* System dependencies
  Ruby on Rails version 6.1.6.1
  Database: Postgres

* Database setup
  rails db:setup

##### Steps to configure the application:
* git clone https://github.com/ahujaak/new_age.git
* cd new_age
* Please make sure you have all the dependencies preinstalled mentioned above.
* bundle install
* rails db:create
* rails db:setup - To migrate and seed the data

#### Insights

* Seed file already contains data to create a driver and it's payment methods.
* We have named the entity "orders" to manage the fuel orders being made by Driver
* We have named the entity "order_adjustments" to manage the adjustments (over-charged or undercharged) on the fuel orders.
* We have created the APIs to create/list the orders and order adjustments.

#### API endpoints:
* To list the orders specific to a driver
` GET /:driver_id/orders`

* To create an order specific to a driver
`POST /:driver_id/orders`

Payload:

```
{
  "order": {
    "fuel_quantity": 3.0,
    "price": 50.5,
    "comment": "Hi this is a test order",
    "payment_method_id": 1
  }
}

```

* To list the Order Adjustments specific to a driver and an order
`GET /:driver_id/orders/:order_id/order_adjustments`

* To create an Order Adjustments specific to a driver and an order
`POST /:driver_id/orders/:order_id/order_adjustments`

Payload:
 -- The possible values of `adjustment_type` are: 'refund' or 'credit' where refund is for over-charged and credit is for under-charged
```

{
  "order_adjustment": {
    "adjustment_type": "refund"
    "amount": 3,
    "description": "The driver was over-charged"
  }
}
```

