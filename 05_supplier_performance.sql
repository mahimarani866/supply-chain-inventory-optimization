-- Supplier / carrier performance overview
SELECT
    shipping_carrier,
    COUNT(*) AS shipment_count,
    ROUND(AVG(shipping_time_days), 1) AS avg_shipping_time_days,
    ROUND(AVG(shipping_cost), 2) AS avg_shipping_cost,
    ROUND(AVG(defect_rate), 4) AS avg_defect_rate
FROM v_supply_chain_clean
GROUP BY shipping_carrier
ORDER BY
    avg_shipping_time_days ASC,
    avg_defect_rate ASC;
