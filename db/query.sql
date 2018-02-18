\c shipt_challenge_db;

SELECT customer_id, first_name, category_id, category, number_purchased FROM
  (SELECT * FROM 
    (SELECT * FROM (
      (SELECT category, category_id, pc_product_id FROM categories 
      INNER JOIN products_categories
      ON category_id=pc_category_id)
    ) AS pc
    INNER JOIN orders_products
    ON pc.pc_product_id = op_product_id) AS categories_ordered
  INNER JOIN orders 
  ON orders.order_id=categories_ordered.op_order_id) AS all_orders
INNER JOIN customers
ON customers.customer_id = all_orders.orders_customer_id;

/* product breakdown */
SELECT o.product, SUM(o.number_purchased) FROM 
(
  SELECT product, number_purchased, t.op_order_id
  FROM (
    SELECT product, number_purchased, op_order_id 
    FROM orders_products
    INNER JOIN products
    ON op_product_id=products.product_id
  ) t
  INNER JOIN orders
  ON t.op_order_id=orders.order_id
  GROUP BY t.product, t.number_purchased, t.op_order_id
) o
GROUP BY o.product;