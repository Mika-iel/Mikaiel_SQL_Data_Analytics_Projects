-- View 1: Order, Customer, Delivery

CREATE VIEW vw_order_customer_delivery AS

SELECT o.order_id , i.item_price, o.quantity, i.item_cat,
i.item_name, o.created_at, a.delivery_add1,
a.delivery_add2, a.delivery_city,
a.delivery_zipcode, o.delivery
FROM orders AS o
LEFT JOIN item AS i ON o.item_id = i.item_id
LEFT JOIN address AS a ON o.add_id = a.add_id;


-- View 2: Item Quantity Summary

CREATE VIEW vw_item_quantity_summary AS

SELECT o.item_id, i.sku, i.item_name, SUM(o.quantity) as order_quantity
FROM orders AS o
LEFT JOIN item AS i ON o.item_id = i.item_id
GROUP BY o.item_id, i.item_name;



-- View 3: Ingredient Cost Analysis

CREATE VIEW vw_ingredient_cost_analysis AS

WITH T1 AS (
SELECT o.item_id, i.sku, i.item_name, r.ing_id, ing.ingr_name,
r.quantity AS recipe_quant, SUM(o.quantity) AS order_quant,
ing.ingr_weight, ing.ingr_price
FROM orders AS o
LEFT JOIN item AS i ON o.item_id = i.item_id
LEFT JOIN recipe AS r ON i.sku = r.recipe_id
LEFT JOIN ingredient AS ing ON r.ing_id = ing.ingr_id
GROUP BY o.item_id, i.sku, i.item_name, r.ing_id, r.quantity
) SELECT item_name, ing_id, ingr_name, 
order_quant, recipe_quant, ingr_price/ingr_weight AS cost_per_unit, order_quant*recipe_quant AS total_recipe,
(ingr_price/ingr_weight)*(order_quant*recipe_quant) AS ingredients_cost
FROM T1;



-- View 4: Inventory Stock Status

CREATE VIEW vw_inventory_stock_status AS

WITH T1 AS (
SELECT o.item_id, i.sku, i.item_name, r.ing_id, ing.ingr_name,
r.quantity AS recipe_quant, SUM(o.quantity) AS order_quant,
ing.ingr_weight, ing.ingr_price
FROM orders AS o
LEFT JOIN item AS i ON o.item_id = i.item_id
LEFT JOIN recipe AS r ON i.sku = r.recipe_id
LEFT JOIN ingredient AS ing ON r.ing_id = ing.ingr_id
GROUP BY o.item_id, i.sku, i.item_name, r.ing_id, r.quantity
), T2 AS (
SELECT ing_id, ingr_name, SUM(order_quant*recipe_quant) AS amount_of_ingr_used
FROM T1
GROUP BY ingr_name, ing_id
) SELECT T2.ingr_name, T2.amount_of_ingr_used,
ingr.ingr_weight*invent.quantity AS total_inv_ingr,
ROUND((((ingr.ingr_weight*invent.quantity)-(T2.amount_of_ingr_used))/(ingr.ingr_weight*invent.quantity))*100,2) AS percentage_of_stock_remaining
FROM T2
LEFT JOIN inventory AS invent ON invent.item_id = T2.ing_id
LEFT JOIN ingredient AS ingr ON ingr.ingr_id = T2.ing_id;



-- View 5: Staff Salary Analysis

CREATE VIEW vw_daily_staff_salary AS

SELECT r.date, st.first_name, st.last_name, st.hourly_rate,
sh.start_time, sh.end_time,
TIMEDIFF(sh.end_time, sh.start_time) AS time_worked,
TIME_TO_SEC(TIMEDIFF(sh.end_time, sh.start_time))/3600 * st.hourly_rate AS daily_salary
FROM rota AS r
LEFT JOIN staff AS st ON r.staff_id = st.staff_id
LEFT JOIN shift AS sh ON r.shift_id = sh.shift_id;