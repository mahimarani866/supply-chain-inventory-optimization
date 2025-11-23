-- Product-type level KPIs
SELECT
    product_type,
    SUM(units_sold) AS total_units_sold,
    ROUND(SUM(revenue_generated), 2) AS total_revenue,
    SUM(stock_level) AS total_stock_level,
    ROUND(
        SUM(stock_level) / NULLIF(SUM(units_sold) / 30, 0),
        1
    ) AS days_of_cover_overall,
    SUM(CASE WHEN stock_level <= 0 THEN 1 ELSE 0 END) AS sku_stockout_count,
    SUM(
        CASE
            WHEN stock_level / NULLIF(units_sold / 30, 0) > 45 THEN 1
            ELSE 0
        END
    ) AS excess_inventory_skus
FROM v_supply_chain_clean
GROUP BY product_type
ORDER BY total_revenue DESC;
