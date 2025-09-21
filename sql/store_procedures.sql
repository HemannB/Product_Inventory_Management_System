CREATE OR REPLACE PROCEDURE AddToInventory(p_product_id INT, p_quantity INT)
LANGUAGE plpgsql
AS $$
BEGIN
UPDATE inventory
SET quantity = quantity + p_quantity
WHERE product_id = p_product_id;

IF NOT FOUND THEN
        INSERT INTO inventory(product_id, quantity)
        VALUES (p_product_id, p_quantity);
END IF;

INSERT INTO transactions(product_id, transaction_type, quantity)
VALUES (p_product_id, 'IN', p_quantity);
END;
$$;

CREATE OR REPLACE PROCEDURE SellProduct(p_product_id INT, p_quantity INT)
LANGUAGE plpgsql
AS $$
DECLARE
v_current_stock INT;
BEGIN
SELECT quantity INTO v_current_stock
FROM inventory
WHERE product_id = p_product_id;

IF v_current_stock IS NULL OR v_current_stock < p_quantity THEN
        RAISE EXCEPTION 'Estoque insuficiente para o produto %', p_product_id;
END IF;

UPDATE inventory
SET quantity = quantity - p_quantity
WHERE product_id = p_product_id;

INSERT INTO transactions(product_id, transaction_type, quantity)
VALUES (p_product_id, 'OUT', p_quantity);
END;
$$;

CREATE OR REPLACE FUNCTION GetStockLevel(p_product_id INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
v_stock INT;
BEGIN
SELECT quantity INTO v_stock
FROM inventory
WHERE product_id = p_product_id;

RETURN COALESCE(v_stock, 0);
END;
$$;
