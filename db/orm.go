package db

import (
  "database/sql"
  // "time"
)

var (
  // db connection handle 
  DBCon *sql.DB
  product string
  amount int64
)

type ProductBreakdown struct {
  Names []string
  Amounts []int64
}

type DateRange struct {
  DateRange string
  Date string 
}

func FetchOrderedProducts(db *sql.DB, dateRange *DateRange) (error, ProductBreakdown) {
  query := `
  SELECT product, number_purchased FROM 
    (
      SELECT * FROM orders_products
      INNER JOIN products
      ON op_product_id=products.product_id
    ) AS prods
  INNER JOIN orders
  ON orders.order_id=prods.op_order_id`

  breakdown := ProductBreakdown{}

  rows, err := db.Query(query)

  if err != nil {
    return err, breakdown
  }

  var products []string
  var amounts []int64

  for rows.Next() {
    rows.Scan(&product, &amount)
    products = append(products, product)
    amounts = append(amounts, amount)
  }

  breakdown.Names = products
  breakdown.Amounts = amounts

  return nil, breakdown
}