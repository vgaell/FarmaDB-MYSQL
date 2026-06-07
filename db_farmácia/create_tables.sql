CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100),
    data_nascimento DATE
);

CREATE TABLE funcionario (
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    cargo VARCHAR(50),
    data_admissao DATE
);

CREATE TABLE produto (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    codigo_barras VARCHAR(50) UNIQUE,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL,
    categoria VARCHAR(50)
);

CREATE TABLE venda (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    id_funcionario INT NOT NULL,
    data_venda DATE NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    forma_pagamento VARCHAR(50),

    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario)
);

CREATE TABLE item_venda (
    id_item INT PRIMARY KEY AUTO_INCREMENT,
    id_venda INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    desconto DECIMAL(10,2) DEFAULT 0,

    FOREIGN KEY (id_venda) REFERENCES venda(id_venda),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

CREATE TABLE remedio (
    id_produto INT PRIMARY KEY,
    principio_ativo VARCHAR(100),
    laboratorio VARCHAR(100),
    tipo VARCHAR(50),
    tarja BOOLEAN,
    registro_anvisa VARCHAR(50),

    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

CREATE TABLE perfumaria (
    id_produto INT PRIMARY KEY,
    marca VARCHAR(100),
    linha VARCHAR(100),
    volume_ml VARCHAR(20),
    genero VARCHAR(30),

    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

CREATE TABLE avulso (
    id_produto INT PRIMARY KEY,
    descricao VARCHAR(255),
    unidade_medida VARCHAR(50),

    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);