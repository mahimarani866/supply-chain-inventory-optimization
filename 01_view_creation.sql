SELECT *
FROM supply_chain_data
LIMIT 10;

CREATE OR REPLACE VIEW v_supply_chain_clean AS
SELECT
    `Product type`                AS product_type,
    `SKU`                         AS sku,
    `Price`                       AS price,
    `Availability`                AS availability,
    `Number of products sold`     AS units_sold,
    `Revenue generated`           AS revenue_generated,
    `Customer demographics`       AS customer_segment,
    `Stock levels`                AS stock_level,
    `Lead times`                  AS lead_time_days,
    `Order quantities`            AS order_quantity,
    `Shipping times`              AS shipping_time_days,
    `Shipping carriers`           AS shipping_carrier,
    `Shipping costs`              AS shipping_cost,
    `Production volumes`          AS production_volume,
    `Manufacturing lead time`     AS mfg_lead_time_days,
    `Manufacturing costs`         AS mfg_cost,
    `Defect rates`                AS defect_rate
FROM supply_chain_data;

SELECT *
FROM v_supply_chain_clean
LIMIT 10;
