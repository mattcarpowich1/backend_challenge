\c shipt_challenge_db;

INSERT INTO categories (category)
VALUES (
  'food'
), (
  'fruits'
), (
  'vegetables'
), (
  'dairy'
), (
  'kitchen'
);

INSERT INTO products (product, unit_price)
VALUES (
  'bananas',
  1.568
), (
  'apples',
  2.33333
), (
  'carrots',
  1.67
), (
  'cheese',
  8.542
), (
  'dish soap',
  4.49
);

INSERT INTO customers (first_name, last_name, email)
VALUES (
  'Matt', 
  'Carpowich',
  'mattcarpowich@gmail.com'
), (
  'John', 
  'Snow',
  'johnsnow99@gmail.com'
);

/* Assign products to their appropriate categories */
INSERT INTO products_categories (pc_product_id, pc_category_id)
VALUES (
  (SELECT product_id FROM products WHERE product='bananas'),
  (SELECT category_id FROM categories WHERE category='food')
), (
  (SELECT product_id FROM products WHERE product='bananas'),
  (SELECT category_id FROM categories WHERE category='fruits')
), (
  (SELECT product_id FROM products WHERE product='apples'),
  (SELECT category_id FROM categories WHERE category='food')
), (
  (SELECT product_id FROM products WHERE product='apples'),
  (SELECT category_id FROM categories WHERE category='fruits')
), (
  (SELECT product_id FROM products WHERE product='carrots'),
  (SELECT category_id FROM categories WHERE category='food')
), (
  (SELECT product_id FROM products WHERE product='carrots'),
  (SELECT category_id FROM categories WHERE category='vegetables')
), (
  (SELECT product_id FROM products WHERE product='cheese'),
  (SELECT category_id FROM categories WHERE category='food')
), (
  (SELECT product_id FROM products WHERE product='cheese'),
  (SELECT category_id FROM categories WHERE category='dairy')
), (
  (SELECT product_id FROM products WHERE product='dish soap'),
  (SELECT category_id FROM categories WHERE category='kitchen')
);

/* Order by Matt Carpowich - 3 bananas, 1 dish soap */
INSERT INTO orders (status, orders_customer_id, created_at, updated_at)
VALUES (
  'DELIVERED',
  (SELECT customer_id FROM customers WHERE email='mattcarpowich@gmail.com'),
  '2018-01-19 21:01:29.167292',
  '2018-01-19 21:01:29.167292'
);


INSERT INTO orders_products (op_order_id, op_product_id, number_purchased)
VALUES (
  (SELECT order_id FROM (
    SELECT * FROM orders WHERE orders_customer_id=(
        SELECT customer_id FROM customers WHERE email='mattcarpowich@gmail.com'
      ) and created_at='2018-01-19 21:01:29.167292'
    ) AS customer_orders
  ),
  (SELECT product_id FROM products WHERE product='bananas'),
  3
);

INSERT INTO orders_products (op_order_id, op_product_id, number_purchased)
VALUES (
  (SELECT order_id FROM (
    SELECT * FROM orders WHERE orders_customer_id=(
        SELECT customer_id FROM customers WHERE email='mattcarpowich@gmail.com'
      ) and created_at='2018-01-19 21:01:29.167292'
    ) AS customer_orders
  ),
  (SELECT product_id FROM products WHERE product='dish soap'),
  1
);

/* Order by John Snow - 2 carrots, 1 banana, 1 dish soap */
INSERT INTO orders (status, orders_customer_id, created_at, updated_at)
VALUES (
  'DELIVERED',
  (SELECT customer_id FROM customers WHERE email='johnsnow99@gmail.com'),
  '2018-02-07 21:01:29.167292',
  '2018-02-07 21:01:29.167292'
);


INSERT INTO orders_products (op_order_id, op_product_id, number_purchased)
VALUES (
  (SELECT order_id FROM (
    SELECT * FROM orders WHERE orders_customer_id=(
        SELECT customer_id FROM customers WHERE email='johnsnow99@gmail.com'
      ) and created_at='2018-02-07 21:01:29.167292'
    ) AS customer_orders
  ),
  (SELECT product_id FROM products WHERE product='carrots'),
  2
);

INSERT INTO orders_products (op_order_id, op_product_id, number_purchased)
VALUES (
  (SELECT order_id FROM (
    SELECT * FROM orders WHERE orders_customer_id=(
        SELECT customer_id FROM customers WHERE email='johnsnow99@gmail.com'
      ) and created_at='2018-02-07 21:01:29.167292'
    ) AS customer_orders
  ),
  (SELECT product_id FROM products WHERE product='bananas'),
  1
);

INSERT INTO orders_products (op_order_id, op_product_id, number_purchased)
VALUES (
  (SELECT order_id FROM (
    SELECT * FROM orders WHERE orders_customer_id=(
        SELECT customer_id FROM customers WHERE email='johnsnow99@gmail.com'
      ) and created_at='2018-02-07 21:01:29.167292'
    ) AS customer_orders
  ),
  (SELECT product_id FROM products WHERE product='dish soap'),
  1
); 
