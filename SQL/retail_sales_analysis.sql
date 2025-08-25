WITH df AS (SELECT
order_items.order_id,
orders.order_date,
EXTRACT(YEAR FROM orders.order_date) AS year,
TO_CHAR(orders.order_date, 'Month') AS month,
products.product_name,
products.category,
products.brand,
products.unit_price,
order_items.quantity,
products.unit_price * order_items.quantity AS total_price,
order_items.discount,
CASE
WHEN order_items.discount > 0
THEN 'Yes'
ELSE 'No' END AS is_discounted,
CAST(
CASE
WHEN order_items.discount > 0
THEN (products.unit_price * order_items.quantity) -
(products.unit_price * order_items.quantity * order_items.discount)
ELSE (products.unit_price * order_items.quantity) END AS INTEGER) AS final_price,
orders.customer_id,
customers.customer_name,
orders.region
FROM project2.order_items
LEFT JOIN project2.products
ON order_items.product_id = products.product_id
LEFT JOIN project2.orders
ON order_items.order_id = orders.order_id
LEFT JOIN project2.customers
ON orders.customer_id = customers.customer_id)

SELECT
*
FROM df
;
