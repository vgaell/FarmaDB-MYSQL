
USE farmacia;
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- =========================================================
-- CONSULTAS SQL - BANCO DE DADOS FARMÁCIA
-- Total: 20 consultas
-- 01 a 05: básicas
-- 06 a 15: intermediárias
-- 16 a 20: avançadas
-- =========================================================

-- 01. Listar todos os clientes
SELECT id_cliente, nome, cpf, telefone, email, data_nascimento
FROM cliente;

-- 02. Listar produtos com preço e estoque
SELECT id_produto, nome, preco, estoque, categoria
FROM produto;

-- 03. Listar funcionários e cargos
SELECT id_funcionario, nome, cargo, data_admissao
FROM funcionario;

-- 04. Listar vendas realizadas
SELECT id_venda, id_cliente, id_funcionario, data_venda, total, forma_pagamento
FROM venda;

-- 05. Listar remédios cadastrados
SELECT id_produto, principio_ativo, laboratorio, tipo, tarja, registro_anvisa
FROM remedio;

-- 06. Categorias diferentes de produtos
SELECT DISTINCT categoria
FROM produto
ORDER BY categoria;

-- 07. Produtos com estoque menor que 50
SELECT id_produto, nome, categoria, estoque
FROM produto
WHERE estoque < 50
ORDER BY estoque ASC;

-- 08. Valor total em estoque de cada produto
SELECT id_produto, nome, preco, estoque, preco * estoque AS valor_total_estoque
FROM produto
ORDER BY valor_total_estoque DESC;

-- 09. Vendas entre datas específicas com Pix ou Crédito
SELECT id_venda, data_venda, total, forma_pagamento
FROM venda
WHERE data_venda BETWEEN '2026-06-01' AND '2026-06-03'
  AND forma_pagamento IN ('Pix', 'Crédito')
ORDER BY data_venda ASC;

-- 10. Quantidade e média de preço por categoria
SELECT
    categoria,
    COUNT(*) AS quantidade_produtos,
    AVG(preco) AS preco_medio,
    MIN(preco) AS menor_preco,
    MAX(preco) AS maior_preco
FROM produto
GROUP BY categoria
HAVING COUNT(*) >= 1
ORDER BY categoria;

-- 11. Vendas com cliente e funcionário
SELECT
    v.id_venda,
    v.data_venda,
    COALESCE(c.nome, 'Cliente não informado') AS cliente,
    f.nome AS funcionario,
    v.total,
    v.forma_pagamento
FROM venda v
LEFT JOIN cliente c ON c.id_cliente = v.id_cliente
INNER JOIN funcionario f ON f.id_funcionario = v.id_funcionario
ORDER BY v.data_venda, v.id_venda;

-- 12. Itens vendidos com subtotal e total do item
SELECT
    iv.id_item,
    v.id_venda,
    p.nome AS produto,
    iv.quantidade,
    iv.preco_unitario,
    iv.desconto,
    iv.quantidade * iv.preco_unitario AS subtotal,
    (iv.quantidade * iv.preco_unitario) - iv.desconto AS total_item
FROM item_venda iv
INNER JOIN venda v ON v.id_venda = iv.id_venda
INNER JOIN produto p ON p.id_produto = iv.id_produto
ORDER BY v.id_venda, iv.id_item;

-- 13. Produtos com preço acima da média
SELECT id_produto, nome, categoria, preco
FROM produto
WHERE preco > (
    SELECT AVG(preco)
    FROM produto
)
ORDER BY preco DESC;

-- 14. União dos tipos específicos de produtos
SELECT p.id_produto, p.nome, 'Remédio' AS tipo_produto, r.laboratorio AS detalhe
FROM produto p
INNER JOIN remedio r ON r.id_produto = p.id_produto

UNION

SELECT p.id_produto, p.nome, 'Perfumaria' AS tipo_produto, pe.marca AS detalhe
FROM produto p
INNER JOIN perfumaria pe ON pe.id_produto = p.id_produto

UNION

SELECT p.id_produto, p.nome, 'Avulso' AS tipo_produto, a.unidade_medida AS detalhe
FROM produto p
INNER JOIN avulso a ON a.id_produto = p.id_produto
ORDER BY tipo_produto, nome;

-- 15. Total vendido por funcionário
SELECT
    f.id_funcionario,
    f.nome AS funcionario,
    f.cargo,
    COUNT(v.id_venda) AS quantidade_vendas,
    SUM(v.total) AS total_vendido
FROM funcionario f
LEFT JOIN venda v ON v.id_funcionario = f.id_funcionario
GROUP BY f.id_funcionario, f.nome, f.cargo
HAVING SUM(v.total) IS NOT NULL
ORDER BY total_vendido DESC;

-- =========================================================
-- CONSULTAS AVANÇADAS
-- =========================================================

DELIMITER $$
-- ==========================================================
-- 16. Trigger para impedir venda com quantidade inválida,
-- desconto negativo ou estoque insuficiente
-- ==========================================================
DROP TRIGGER IF EXISTS trg_item_venda_validar_estoque$$

CREATE TRIGGER trg_item_venda_validar_estoque
BEFORE INSERT ON item_venda
FOR EACH ROW
BEGIN
    DECLARE estoque_atual INT;

    SELECT estoque
    INTO estoque_atual
    FROM produto
    WHERE id_produto = NEW.id_produto;

    IF NEW.quantidade <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A quantidade deve ser maior que zero.';
    END IF;

    IF NEW.desconto < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O desconto não pode ser negativo.';
    END IF;

    IF estoque_atual IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Produto não encontrado.';
    END IF;

    IF estoque_atual < NEW.quantidade THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Estoque insuficiente para esta venda.';
    END IF;
END$$

USE farmacia;

-- =====================================================
-- 17. VIEW
-- Cria uma visão para facilitar consultas de vendas.
-- =====================================================

DROP VIEW IF EXISTS vw_relatorio_vendas;

CREATE VIEW vw_relatorio_vendas AS
SELECT
    v.id_venda,
    c.nome AS cliente,
    f.nome AS funcionario,
    v.data_venda,
    v.total,
    v.forma_pagamento
FROM venda v
INNER JOIN cliente c
    ON c.id_cliente = v.id_cliente
INNER JOIN funcionario f
    ON f.id_funcionario = v.id_funcionario;

-- Consulta da View
SELECT *
FROM vw_relatorio_vendas;



-- =====================================================
-- 18. INDEX
-- Cria índice para melhorar buscas por cliente.
-- =====================================================

CREATE INDEX idx_venda_cliente
ON venda(id_cliente);


show index 
from venda; 



-- =====================================================
-- 19. PROCEDURE
-- Lista todas as vendas de um cliente.
-- =====================================================

DELIMITER $$

DROP PROCEDURE IF EXISTS sp_vendas_por_cliente $$

CREATE PROCEDURE sp_vendas_por_cliente(
    IN p_id_cliente INT
)
BEGIN

    SELECT
        v.id_venda,
        c.nome AS cliente,
        v.data_venda,
        v.total,
        v.forma_pagamento
    FROM venda v
    INNER JOIN cliente c
        ON c.id_cliente = v.id_cliente
    WHERE v.id_cliente = p_id_cliente;

END $$

DELIMITER ;

-- Execução da Procedure
CALL sp_vendas_por_cliente(2);



-- =====================================================
-- 20. FUNCTION
-- Aplica desconto em um valor.
-- =====================================================

DELIMITER $$

DROP FUNCTION IF EXISTS fn_aplicar_desconto $$

CREATE FUNCTION fn_aplicar_desconto(
    valor DECIMAL(10,2),
    percentual DECIMAL(5,2)
)

RETURNS DECIMAL(10,2)

DETERMINISTIC

BEGIN

    RETURN valor - (valor * percentual / 100);

END $$

DELIMITER ;

-- Utilização da Function
SELECT
    nome,
    preco,
    fn_aplicar_desconto(preco,10) AS preco_com_desconto
FROM produto;



-- =====================================================
-- 21. ESTRUTURA DE DECISÃO (IF / ELSEIF / ELSE)
-- Classifica estoque dos produtos.
-- =====================================================

DELIMITER $$

DROP FUNCTION IF EXISTS fn_status_estoque $$

CREATE FUNCTION fn_status_estoque(
    qtd INT
)

RETURNS VARCHAR(30)

DETERMINISTIC

BEGIN

    IF qtd < 10 THEN

        RETURN 'Estoque Crítico';

    ELSEIF qtd < 50 THEN

        RETURN 'Estoque Baixo';

    ELSE

        RETURN 'Estoque Normal';

    END IF;

END $$

DELIMITER ;

-- Consulta utilizando IF
SELECT
    nome,
    estoque,
    fn_status_estoque(estoque) AS status_estoque
FROM produto;



-- =====================================================
-- 22. CASE / WHEN
-- Classifica produtos por faixa de preço.
-- =====================================================

SELECT

    nome,
    preco,

    CASE

        WHEN preco < 10 THEN
            'Produto Barato'

        WHEN preco BETWEEN 10 AND 50 THEN
            'Produto Intermediário'

        ELSE
            'Produto Caro'

    END AS classificacao_preco

FROM produto;



-- =====================================================
-- 24. GRANT
-- Concede permissão de consulta.
-- =====================================================

GRANT SELECT
ON farmacia.produto
TO 'usuario_caixa'@'localhost';



-- =====================================================
-- REVOKE
-- Remove a permissão concedida.
-- =====================================================

REVOKE SELECT
ON farmacia.produto
FROM 'usuario_caixa'@'localhost';



-- =====================================================
-- 25. TRIGGER
-- Atualiza estoque automaticamente após venda.
-- =====================================================

DELIMITER $$

DROP TRIGGER IF EXISTS trg_atualiza_estoque $$

CREATE TRIGGER trg_atualiza_estoque

AFTER INSERT
ON item_venda

FOR EACH ROW

BEGIN

    UPDATE produto

    SET estoque = estoque - NEW.quantidade

    WHERE id_produto = NEW.id_produto;

END $$

DELIMITER ;



-- =====================================================
-- TESTE DA TRIGGER
-- Ao inserir um item de venda o estoque será reduzido.
-- =====================================================

INSERT INTO item_venda (id_venda, id_produto, quantidade, preco_unitario, desconto) VALUES (1,1,2,15.00,0);


-- =====================================================
-- CONSULTA FINAL DE VERIFICAÇÃO
-- =====================================================

SELECT
    id_produto,
    nome,
    estoque
FROM produto;