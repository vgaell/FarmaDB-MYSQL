USE farmacia;
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- =========================================
-- CLIENTES
-- =========================================

INSERT INTO cliente (nome, cpf, telefone, email, data_nascimento) VALUES
('Ana Souza','123.456.789-01','61999991111','ana@email.com','1995-04-12'),
('Carlos Lima','123.456.789-02','61999992222','carlos@email.com','1988-09-25'),
('Mariana Alves','123.456.789-03','61999993333','mariana@email.com','2001-01-30'),
('João Pereira','123.456.789-04','61999994444','joao@email.com','1979-06-18'),
('Fernanda Rocha','123.456.789-05','61999995555','fernanda@email.com','1992-11-07'),
('Lucas Martins','123.456.789-06','61999996666','lucas@email.com','1997-03-14'),
('Beatriz Costa','123.456.789-07','61999997777','beatriz@email.com','1999-08-22'),
('Rafael Santos','123.456.789-08','61999998888','rafael@email.com','1985-12-11'),
('Patricia Gomes','123.456.789-09','61999990000','patricia@email.com','1990-05-09'),
('Gabriel Oliveira','123.456.789-10','61999881111','gabriel@email.com','1998-01-15'),
('Juliana Castro','123.456.789-11','61999882222','juliana@email.com','1987-02-28'),
('Ricardo Lopes','123.456.789-12','61999883333','ricardo@email.com','1993-04-04'),
('Vanessa Melo','123.456.789-13','61999884444','vanessa@email.com','2000-07-18'),
('Thiago Silva','123.456.789-14','61999885555','thiago@email.com','1986-11-23'),
('Amanda Ribeiro','123.456.789-15','61999886666','amanda@email.com','1994-10-08');

-- =========================================
-- FUNCIONÁRIOS
-- =========================================

INSERT INTO funcionario (nome, cpf, cargo, data_admissao) VALUES
('Paulo Mendes','111.111.111-11','Farmacêutico','2020-03-10'),
('Juliana Costa','222.222.222-22','Atendente','2021-07-15'),
('Ricardo Gomes','333.333.333-33','Caixa','2022-01-20'),
('Marcos Silva','444.444.444-44','Gerente','2019-06-01'),
('Tatiane Alves','555.555.555-55','Farmacêutica','2023-02-10'),
('Felipe Rocha','666.666.666-66','Estoquista','2021-09-12'),
('Bruna Souza','777.777.777-77','Atendente','2022-11-01'),
('Leonardo Lima','888.888.888-88','Caixa','2024-01-08');

-- =========================================
-- PRODUTOS
-- =========================================

INSERT INTO produto (nome,codigo_barras,preco,estoque,categoria) VALUES
('Dipirona 500mg','789100000001',8.90,120,'Remédio'),
('Paracetamol 750mg','789100000002',12.50,90,'Remédio'),
('Ibuprofeno 600mg','789100000003',15.90,80,'Remédio'),
('Amoxicilina 500mg','789100000004',35.00,40,'Remédio'),
('Losartana 50mg','789100000005',18.50,70,'Remédio'),
('Omeprazol 20mg','789100000006',19.90,65,'Remédio'),
('Vitamina C','789100000007',22.00,100,'Remédio'),
('Loratadina','789100000008',14.00,90,'Remédio'),
('Neosaldina','789100000009',10.50,75,'Remédio'),
('Nimesulida','789100000010',16.00,50,'Remédio'),
('Shampoo Anticaspa','789100000011',22.90,60,'Perfumaria'),
('Condicionador Hidratante','789100000012',24.90,50,'Perfumaria'),
('Perfume Sport','789100000013',89.90,20,'Perfumaria'),
('Perfume Floral','789100000014',95.00,18,'Perfumaria'),
('Sabonete Líquido','789100000015',12.90,80,'Perfumaria'),
('Creme Dental','789100000016',8.50,150,'Perfumaria'),
('Escova Dental','789100000017',7.90,130,'Perfumaria'),
('Desodorante Aerosol','789100000018',18.90,90,'Perfumaria'),
('Protetor Solar','789100000019',42.90,40,'Perfumaria'),
('Hidratante Corporal','789100000020',29.90,35,'Perfumaria'),
('Algodão 100g','789100000021',6.00,150,'Avulso'),
('Álcool 70%','789100000022',9.90,100,'Avulso'),
('Seringa Descartável','789100000023',2.50,200,'Avulso'),
('Gaze Estéril','789100000024',3.90,300,'Avulso'),
('Curativo Adesivo','789100000025',7.90,180,'Avulso');

-- =========================================
-- REMÉDIOS
-- =========================================

INSERT INTO remedio
(id_produto,principio_ativo,laboratorio,tipo,tarja,registro_anvisa)
VALUES
(1,'Dipirona Sódica','Neo Química','Analgésico',FALSE,'ANVISA123456'),
(2,'Paracetamol','Medley','Analgésico',FALSE,'ANVISA234567'),
(3,'Ibuprofeno','EMS','Anti-inflamatório',FALSE,'ANVISA345678'),
(4,'Amoxicilina','EMS','Antibiótico',TRUE,'ANVISA456789'),
(5,'Losartana Potássica','Neo Química','Anti-hipertensivo',TRUE,'ANVISA567890'),
(6,'Omeprazol','Medley','Gastrite',FALSE,'ANVISA678901'),
(7,'Ácido Ascórbico','Cimed','Vitamina',FALSE,'ANVISA789012'),
(8,'Loratadina','Eurofarma','Antialérgico',FALSE,'ANVISA890123'),
(9,'Dipirona + Cafeína','Hypera','Analgésico',FALSE,'ANVISA901234'),
(10,'Nimesulida','EMS','Anti-inflamatório',TRUE,'ANVISA012345');

-- =========================================
-- PERFUMARIA
-- =========================================

INSERT INTO perfumaria
(id_produto,marca,linha,volume_ml,genero)
VALUES
(11,'Clear','Anticaspa','400ml','Unissex'),
(12,'Pantene','Hidratação','350ml','Unissex'),
(13,'Boticário','Sport','100ml','Masculino'),
(14,'Boticário','Floral','100ml','Feminino'),
(15,'Nivea','Flor de Cerejeira','250ml','Feminino'),
(16,'Colgate','Total 12','90g','Unissex'),
(17,'Oral-B','Indicator','Unidade','Unissex'),
(18,'Rexona','Clinical','150ml','Masculino'),
(19,'Nivea','Sun Protect','200ml','Unissex'),
(20,'Nivea','Milk','400ml','Unissex');

-- =========================================
-- AVULSOS
-- =========================================

INSERT INTO avulso
(id_produto,descricao,unidade_medida)
VALUES
(21,'Algodão hidrófilo 100g','Pacote'),
(22,'Álcool etílico 70%','Frasco'),
(23,'Seringa descartável estéril','Unidade'),
(24,'Gaze estéril','Pacote'),
(25,'Curativo adesivo','Caixa');

-- =========================================
-- VENDAS
-- =========================================

INSERT INTO venda
(id_cliente,id_funcionario,data_venda,total,forma_pagamento)
VALUES
(1,2,'2026-06-01',21.40,'Pix'),
(2,3,'2026-06-01',89.90,'Crédito'),
(3,1,'2026-06-01',35.00,'Dinheiro'),
(4,2,'2026-06-02',47.80,'Débito'),
(5,3,'2026-06-02',102.50,'Pix'),
(6,1,'2026-06-02',18.90,'Dinheiro'),
(7,4,'2026-06-03',64.70,'Pix'),
(8,2,'2026-06-03',29.90,'Débito'),
(9,5,'2026-06-03',85.40,'Crédito'),
(10,3,'2026-06-04',120.00,'Pix');

-- =========================================
-- ITENS DE VENDA
-- =========================================

INSERT INTO item_venda
(id_venda,id_produto,quantidade,preco_unitario,desconto)
VALUES
(1,1,1,8.90,0),
(1,2,1,12.50,0),
(2,13,1,89.90,0),
(3,4,1,35.00,0),
(4,21,2,6.00,0),
(4,22,1,9.90,0),
(4,24,2,3.90,0),
(5,19,1,42.90,0),
(5,11,1,22.90,0),
(5,12,1,24.90,0),
(6,18,1,18.90,0),
(7,5,2,18.50,0),
(7,8,2,14.00,0),
(8,20,1,29.90,0),
(9,14,1,95.00,9.60),
(10,19,2,42.90,0),
(10,15,1,12.90,0);
