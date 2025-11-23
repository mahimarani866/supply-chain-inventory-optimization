SELECT
    sku,
    product_type,
    stock_level,
    lead_time_days,
    units_sold,
    ROUND(units_sold / 30, 2) AS daily_demand,
    ROUND((units_sold / 30) * lead_time_days, 2) AS reorder_point,
    CASE
        WHEN stock_level <= 0 THEN 'Stockout'
        WHEN stock_level < (units_sold / 30) * lead_time_days THEN 'At Risk'
        ELSE 'Safe'
    END AS stock_status
FROM v_supply_chain_clean
ORDER BY
    stock_status,
    stock_level ASC
LIMIT 50;

-- Fast vs slow movers and excess inventory
SELECT
    sku,
    product_type,
    stock_level,
    units_sold,
    ROUND(units_sold / 30, 2) AS daily_demand,
    ROUND(
        stock_level / NULLIF(units_sold / 30, 0),
        1
    ) AS days_of_cover,
    CASE
        WHEN stock_level <= 0 THEN 'Stockout'
        WHEN stock_level / NULLIF(units_sold / 30, 0) < 7
            THEN 'Fast mover - low cover'
        WHEN stock_level / NULLIF(units_sold / 30, 0) BETWEEN 7 AND 30
            THEN 'Healthy'
        ELSE 'Excess inventory'
    END AS inventory_health
FROM v_supply_chain_clean
ORDER BY
    CASE
        WHEN stock_level <= 0 THEN 1
        WHEN stock_level / NULLIF(units_sold / 30, 0) < 7 THEN 2
        WHEN stock_level / NULLIF(units_sold / 30, 0) BETWEEN 7 AND 30 THEN 3
        ELSE 4
    END,
    days_of_cover DESC
LIMIT 50;
