--- COMANDOS PARA CRIAÇÃO DAS TABELAS E SEUS RELACIONAMENTOS ---
CREATE DATABASE farma_tck10;
USE farma_tck10;

CREATE TABLE cidade (
    id_cidade INT PRIMARY KEY,
    uf VARCHAR(255),
    nome_cidade VARCHAR(255)
);

CREATE TABLE papel (
    id_cargo INT PRIMARY KEY,
    ds_cargo VARCHAR(255)
);

CREATE TABLE usuario_externo (
    id_usuario_externo INT PRIMARY KEY,
    cnpj VARCHAR(20),  
    email VARCHAR(255),
    telefone INT
);

CREATE TABLE plataforma (
    id_plataforma INT PRIMARY KEY,
    ds_plataforma VARCHAR(255)
);

CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(255),
    telefone BIGINT,
    email VARCHAR(255),
    idade INT,
    endereco VARCHAR(255),
    cliente_tipo INT
);

CREATE TABLE funcionario (
    id_funcionario INT PRIMARY KEY,
    nome VARCHAR(255),
    cpf BIGINT,
    cargo_id_cargo INT,
    telefone1 BIGINT,
    telefone2 BIGINT,
    email VARCHAR(255),
    FOREIGN KEY (cargo_id_cargo) REFERENCES papel(id_cargo) ON DELETE CASCADE
);

CREATE TABLE pedido_status (
    id_pedido_status INT PRIMARY KEY,
    status_nome VARCHAR(255),
    descricao VARCHAR(255)
);

CREATE TABLE fornecedor (
    id_fornecedor INT PRIMARY KEY,
    cnpj BIGINT,
    nome_fantasia VARCHAR(255),
    razao_social VARCHAR(255),
    telefone VARCHAR(20),
    email VARCHAR(255),
    id_cidade_fornecedor INT,
    FOREIGN KEY (id_cidade_fornecedor) REFERENCES cidade(id_cidade) ON DELETE CASCADE
);

CREATE TABLE produto_categoria (
    id_produto_categoria INT PRIMARY KEY,
    nome VARCHAR(255)
);

CREATE TABLE produto_tipo (
    id_produto_tipo INT PRIMARY KEY,
    nome VARCHAR(255),
    produto_categoria_id_produto_categoria INT,
    FOREIGN KEY (produto_categoria_id_produto_categoria) REFERENCES produto_categoria(id_produto_categoria) ON DELETE CASCADE
);

CREATE TABLE marca (
    id_marca INT PRIMARY KEY,
    nome_marca VARCHAR(255)
);

CREATE TABLE produto (
    id_produto INT PRIMARY KEY,
    produto_tipo_id_produto_tipo INT,
    nome_produto VARCHAR(255),
    controlado TINYINT,
    FOREIGN KEY (produto_tipo_id_produto_tipo) REFERENCES produto_tipo(id_produto_tipo) ON DELETE CASCADE
);

CREATE TABLE produto_marca (
    marca_id_marca INT,
    produto_id_produto INT,
    preco DOUBLE PRECISION,
    PRIMARY KEY (marca_id_marca, produto_id_produto),
    FOREIGN KEY (marca_id_marca) REFERENCES marca(id_marca) ON DELETE CASCADE,
    FOREIGN KEY (produto_id_produto) REFERENCES produto(id_produto) ON DELETE CASCADE
);

CREATE TABLE pedido (
    id_pedido INT PRIMARY KEY,
    cliente_id_cliente INT,
    pedido_status_id_pedido_status INT,
    controlado TINYINT,
    plataforma_id_plataforma_pedido INT,
    cidade_id_pedido_cidade INT,
    data_pedido DATE,
    data_hora DATETIME,
    FOREIGN KEY (cliente_id_cliente) REFERENCES cliente(id_cliente) ON DELETE CASCADE,
    FOREIGN KEY (pedido_status_id_pedido_status) REFERENCES pedido_status(id_pedido_status) ON DELETE CASCADE,
    FOREIGN KEY (plataforma_id_plataforma_pedido) REFERENCES plataforma(id_plataforma) ON DELETE CASCADE,
    FOREIGN KEY (cidade_id_pedido_cidade) REFERENCES cidade(id_cidade) ON DELETE CASCADE
);

CREATE TABLE pedido_item (
    id_pedido_item INT PRIMARY KEY,
    pedido_id_pedido INT,
    preco DOUBLE PRECISION,
    desconto DOUBLE PRECISION,
    marca_id_marca INT,
    produto_id_produto INT,
    qtd_item INT,
    data_item DATE,
    FOREIGN KEY (pedido_id_pedido) REFERENCES pedido(id_pedido) ON DELETE CASCADE,
    FOREIGN KEY (marca_id_marca) REFERENCES produto_marca(marca_id_marca) ON DELETE CASCADE,
    FOREIGN KEY (produto_id_produto) REFERENCES produto(id_produto) ON DELETE CASCADE
);


CREATE TABLE farmacia (
    id INT PRIMARY KEY,
    nome VARCHAR(255),
    gerente_id_funcionario INT,
    FOREIGN KEY (gerente_id_funcionario) REFERENCES funcionario(id_funcionario) ON DELETE SET NULL
);

CREATE TABLE venda (
    id_venda INT PRIMARY KEY,
    data_venda DATE,
    preco_venda DOUBLE PRECISION,
    pedido_id_pedido INT,
    pedido_item_desconto DOUBLE PRECISION,
    frete DOUBLE PRECISION,
    farmacia_id INT,
    entregador_id_funcionario INT,
    FOREIGN KEY (pedido_id_pedido) REFERENCES pedido(id_pedido) ON DELETE CASCADE,
    FOREIGN KEY (farmacia_id) REFERENCES farmacia(id) ON DELETE SET NULL,
    FOREIGN KEY (entregador_id_funcionario) REFERENCES funcionario(id_funcionario) ON DELETE SET NULL
);

CREATE TABLE estoque (
    fornecedor_id_fornecedor INT,
    produto_marca_id_marca INT,
    preco DOUBLE PRECISION,
    qtd_minima INT,
    produto_marca_id_produto INT,
    lote INT,
    PRIMARY KEY (fornecedor_id_fornecedor, produto_marca_id_marca, produto_marca_id_produto),
    FOREIGN KEY (fornecedor_id_fornecedor) REFERENCES fornecedor(id_fornecedor) ON DELETE CASCADE,
    FOREIGN KEY (produto_marca_id_marca, produto_marca_id_produto) REFERENCES produto_marca(marca_id_marca, produto_id_produto) ON DELETE CASCADE
);

CREATE TABLE receita (
    id_receita INT PRIMARY KEY,
    beneficiario VARCHAR(255)
);

CREATE TABLE produto_vencimento (
    marca_id_marca INT,
    produto_id_produto INT,
    data_vencimento DATE,
    PRIMARY KEY (marca_id_marca, produto_id_produto),
    FOREIGN KEY (marca_id_marca, produto_id_produto) REFERENCES produto_marca(marca_id_marca, produto_id_produto) ON DELETE CASCADE
);



-- Inserindo dados na tabela 'cidade'
INSERT INTO cidade (id_cidade, uf, nome_cidade) VALUES
(1, 'SP', 'São Paulo'),
(2, 'RJ', 'Rio de Janeiro'),
(3, 'MG', 'Belo Horizonte'),
(4, 'RS', 'Porto Alegre'),
(5, 'PR', 'Curitiba');

-- Inserindo dados na tabela 'papel'
INSERT INTO papel (id_cargo, ds_cargo) VALUES
(1, 'Atendente'),
(2, 'Farmacêutico'),
(3, 'Gerente'),
(4, 'Estoquista'),
(5, 'Recepcionista');


INSERT INTO usuario_externo (id_usuario_externo, cnpj, email, telefone) VALUES
(1, '12345678901234', 'usuario1@farmacia.com', 987654321),
(2, '98765432109876', 'usuario2@farmacia.com', 123456789),
(3, '11112222333344', 'usuario3@farmacia.com', 999888777),
(4, '55556666777788', 'usuario4@farmacia.com', 444333222),
(5, '99990000111122', 'usuario5@farmacia.com', 666555444);


-- Inserindo dados na tabela 'cliente'
INSERT INTO cliente (id_cliente, nome, telefone, email, idade, endereco, cliente_tipo) VALUES
(1, 'João Cliente', 1122334455, 'joao.cliente@email.com', 35, 'Rua A, 123', 1),
(2, 'Maria Silva', 9988776655, 'maria.silva@email.com', 28, 'Avenida B, 456', 1),
(3, 'Carlos Souza', 3344556677, 'carlos.souza@email.com', 45, 'Rua C, 789', 2),
(4, 'Ana Oliveira', 6677889900, 'ana.oliveira@email.com', 50, 'Avenida D, 1011', 2),
(5, 'Pedro Santos', 1122334455, 'pedro.santos@email.com', 40, 'Rua E, 1213', 3),
(6, 'Lucas Pereira', '11987654321', 'lucas.pereira@email.com', 30, 'Rua F, 1415', 1);


-- Inserindo dados na tabela 'funcionario'
INSERT INTO funcionario (id_funcionario, nome, cpf, cargo_id_cargo) VALUES
(1, 'Fábio Funcionario', 12345678901, 2),
(2, 'Amanda Atendente', 98765432109, 1),
(3, 'Lucia Gerente', 11112222333, 3),
(4, 'Marcos Estoquista', 55556666777, 4),
(5, 'Isabel Recepcionista', 99990000111, 5),
(6, 'Entregador1', 99990000111, 5),
(7, 'Entregador2', 99990000111, 5);


-- Inserindo dados na tabela 'pedido_status'
INSERT INTO pedido_status (id_pedido_status, status_nome, descricao) VALUES
(1, 'Em andamento', 'Pedido está sendo processado'),
(2, 'Concluído', 'Pedido concluído com sucesso'),
(3, 'Cancelado', 'Pedido foi cancelado');

-- Inserindo dados na tabela 'fornecedor'
INSERT INTO fornecedor (id_fornecedor, cnpj, nome_fantasia, razao_social, telefone, email, id_cidade_fornecedor) VALUES
(1, 87654321098765, 'Fornecedor1', 'Fornecedor1 Razão Social', '1122334455', 'fornecedor1@email.com', 1),
(2, 43210987654321, 'Fornecedor2', 'Fornecedor2 Razão Social', '9988776655', 'fornecedor2@email.com', 2),
(3, 11112222333344, 'Fornecedor3', 'Fornecedor3 Razão Social', '3344556677', 'fornecedor3@email.com', 3),
(4, 55556666777788, 'Fornecedor4', 'Fornecedor4 Razão Social', '6677889900', 'fornecedor4@email.com', 4),
(5, 99990000111122, 'Fornecedor5', 'Fornecedor5 Razão Social', '1122334455', 'fornecedor5@email.com', 5);

-- Inserindo dados na tabela 'produto_categoria'
INSERT INTO produto_categoria (id_produto_categoria, nome) VALUES
(1, 'Medicamento'),
(2, 'Higiene Pessoal'),
(3, 'Perfumaria'),
(4, 'Cosmético'),
(5, 'Alimento');

-- Inserindo dados na tabela 'produto_tipo'
INSERT INTO produto_tipo (id_produto_tipo, nome, produto_categoria_id_produto_categoria) VALUES
(1, 'Analgésico', 1),
(2, 'Shampoo', 2),
(3, 'Perfume', 3),
(4, 'Creme Facial', 4),
(5, 'Vitaminas', 5);

-- Inserindo dados na tabela 'marca'
INSERT INTO marca (id_marca, nome_marca) VALUES
(1, 'Marca1'),
(2, 'Marca2'),
(3, 'Marca3'),
(4, 'Marca4'),
(5, 'Marca5');

-- Inserindo dados na tabela 'produto'
INSERT INTO produto (id_produto, produto_tipo_id_produto_tipo, nome_produto, controlado) VALUES
(1, 1, 'Dorflex', 1),
(2, 2, 'Pantene', 0),
(3, 3, 'Chanel No. 5', 0),
(4, 4, 'Nívea Q10', 0),
(5, 5, 'Centrum', 0);

-- Inserindo dados na tabela 'produto_marca'
INSERT INTO produto_marca (marca_id_marca, produto_id_produto, preco) VALUES
(1, 1, 20.99),
(2, 2, 15.50),
(3, 3, 150.00),
(4, 4, 30.00),
(5, 5, 25.99);

-- Inserindo dados na tabela 'plataforma'
INSERT INTO plataforma (id_plataforma, ds_plataforma) VALUES
(1, 'loja'),
(2, 'portal'),
(3, 'aplicativo');

-- Inserindo dados na tabela 'pedido'
INSERT INTO pedido (id_pedido, cliente_id_cliente, pedido_status_id_pedido_status, controlado, plataforma_id_plataforma_pedido, cidade_id_pedido_cidade, data_pedido, data_hora) VALUES
(1, 1, 1, 0, 3, 1, '2023-11-14', '2023-11-14 10:30:00'),
(2, 2, 1, 0, 3, 2, '2023-11-14', '2023-11-14 11:45:00'),
(3, 3, 2, 1, 3, 3, '2023-11-14', '2023-11-14 13:15:00'),
(4, 4, 2, 1, 3, 4, '2023-11-14', '2023-11-14 14:30:00'),
(5, 5, 3, 0, 3, 5, '2023-11-14', '2023-11-14 16:00:00'),
(6, 6, 1, 0, 1, 1, '2023-11-14', '2023-11-14 09:00:00'),
(7, 6, 2, 0, 2, 2, '2023-11-15', '2023-11-15 10:00:00');

-- Inserindo dados na tabela 'pedido_item'
INSERT INTO pedido_item (id_pedido_item, pedido_id_pedido, preco, desconto, marca_id_marca, produto_id_produto, qtd_item, data_item) VALUES
(1, 1, 20.99, 2.00, 1, 1, 3, '2023-11-14'),
(2, 2, 15.50, 1.50, 2, 2, 2, '2023-11-14'),
(3, 3, 150.00, 0.00, 3, 3, 1, '2023-11-14'),
(4, 4, 30.00, 5.00, 4, 4, 1, '2023-11-14'),
(5, 5, 25.99, 3.00, 5, 5, 4, '2023-11-14'),
(6, 6, 50.00, 5.00, 1, 1, 2, '2023-11-14'),
(7, 7, 30.00, 0.00, 2, 2, 1, '2023-11-15');

-- Inserindo dados na tabela 'farmacia'
INSERT INTO farmacia (id, nome, gerente_id_funcionario) VALUES
(1, 'Farmacia A', 3), 
(2, 'Farmacia B', 3), 
(3, 'Farmacia C', 3), 
(4, 'Farmacia D', 3), 
(5, 'Farmacia E', 3);

-- Inserindo dados na tabela 'venda'
INSERT INTO venda (id_venda, data_venda, preco_venda, pedido_id_pedido, pedido_item_desconto, frete, farmacia_id, entregador_id_funcionario) VALUES
(1, '2023-11-15', 60.97, 1, 2.00, 5.00, 1, 6), -- Farmacia A
(2, '2023-11-15', 29.00, 2, 1.50, 3.00, 2, 7), -- Farmacia B
(3, '2023-11-15', 150.00, 3, 0.00, 8.00, 3, 6), -- Farmacia C
(4, '2023-11-15', 25.00, 4, 5.00, 4.00, 4, 7), -- Farmacia D
(5, '2023-11-15', 97.96, 5, 3.00, 6.00, 5, 6); -- Farmacia E

-- Inserindo dados na tabela 'estoque'
INSERT INTO estoque (fornecedor_id_fornecedor, produto_marca_id_marca, preco, qtd_minima, produto_marca_id_produto, lote) VALUES
(1, 1, 20.99, 10, 1, 12345),
(2, 2, 15.50, 15, 2, 67890),
(3, 3, 150.00, 5, 3, 13579),
(4, 4, 30.00, 8, 4, 24680),
(5, 5, 25.99, 12, 5, 98765);

-- Inserindo dados na tabela 'receita'
INSERT INTO receita (id_receita, beneficiario) VALUES
(1, 'Joana Oliveira'),
(2, 'Ricardo Souza'),
(3, 'Fernanda Silva'),
(4, 'Pedro Santos'),
(5, 'Laura Martins');


--- COMANDOS PARA A CONSULTA 1 ---

SELECT
    p.id_produto AS codigo,
    p.nome_produto AS nome,
    m.nome_marca AS fabricante,
    SUM(e.qtd_minima) AS quantidade,
    c.nome_cidade AS cidade,
    c.uf
FROM
    produto p
JOIN
    produto_marca pm ON p.id_produto = pm.produto_id_produto
JOIN
    marca m ON pm.marca_id_marca = m.id_marca
JOIN
    estoque e ON pm.marca_id_marca = e.produto_marca_id_marca AND pm.produto_id_produto = e.produto_marca_id_produto
JOIN
    fornecedor f ON e.fornecedor_id_fornecedor = f.id_fornecedor
JOIN
    cidade c ON f.id_cidade_fornecedor = c.id_cidade
WHERE
    c.id_cidade = 5
GROUP BY
    p.id_produto, p.nome_produto, m.nome_marca, c.nome_cidade, c.uf
ORDER BY
    p.nome_produto;


--- COMANDOS PARA A CONSULTA 2 ---

WITH ComprasPorCliente AS (
    SELECT
        c.id_cliente,
        c.nome,
        c.telefone,
        c.idade,
        COUNT(DISTINCT pe.id_pedido) AS nr_de_compras
    FROM
        cliente c
    JOIN
        pedido pe ON c.id_cliente = pe.cliente_id_cliente
    WHERE
        pe.cidade_id_pedido_cidade IN (SELECT id_cidade FROM cidade WHERE uf = 'SP')
    GROUP BY
        c.id_cliente, c.nome, c.telefone, c.idade
)

SELECT
    cc.id_cliente AS id,
    cc.nome,
    cc.telefone,
    cc.idade,
    cc.nr_de_compras
FROM
    ComprasPorCliente cc
JOIN
    (
        SELECT
            MAX(nr_de_compras) AS max_compras
        FROM
            ComprasPorCliente
    ) maxCompras ON cc.nr_de_compras = maxCompras.max_compras;


--- COMANDOS PARA A CONSULTA 3 ---

SELECT
    p.id_pedido AS id_compra,
    c.nome AS cliente,
    SUM(pi.preco - pi.desconto) AS valor_total,
    CASE
        WHEN p.plataforma_id_plataforma_pedido = 1 THEN 'loja'
        WHEN p.plataforma_id_plataforma_pedido = 2 THEN 'portal'
        ELSE 'Outro'
    END AS plataforma,
    p.data_pedido AS data,
    p.data_hora AS hora
FROM
    pedido p
JOIN
    cliente c ON p.cliente_id_cliente = c.id_cliente
JOIN
    pedido_item pi ON p.id_pedido = pi.pedido_id_pedido
WHERE
    p.data_pedido BETWEEN '2023-11-14' AND '2023-11-15'
    AND p.plataforma_id_plataforma_pedido NOT IN (3)
GROUP BY
    p.id_pedido, c.nome, p.plataforma_id_plataforma_pedido, p.data_pedido
ORDER BY
    p.data_pedido DESC
LIMIT 0, 1000;

--- COMANDOS PARA A CONSULTA 4 ---

SELECT
    c.id_cliente,
    c.nome,
    c.telefone,
    c.idade,
    COUNT(pi.id_pedido_item) AS total_compras_ultimo_ano
FROM
    cliente c
LEFT JOIN
    pedido p ON c.id_cliente = p.cliente_id_cliente
LEFT JOIN
    pedido_item pi ON p.id_pedido = pi.pedido_id_pedido
WHERE
    pi.data_item <= CURDATE() - INTERVAL 30 DAY OR pi.data_item IS NULL
GROUP BY
    c.id_cliente, c.nome, c.telefone, c.idade;

--- COMANDOS PARA A CONSULTA 5 ---

SELECT
    e.lote,
    p.nome_produto,
    pm.preco,
    e.qtd_minima,
    COUNT(*) AS quantidade,
    pv.data_vencimento
FROM
    estoque e
JOIN
    produto_marca pm ON e.produto_marca_id_marca = pm.marca_id_marca AND e.produto_marca_id_produto = pm.produto_id_produto
JOIN
    produto p ON pm.produto_id_produto = p.id_produto
LEFT JOIN
    produto_vencimento pv ON pm.marca_id_marca = pv.marca_id_marca AND pm.produto_id_produto = pv.produto_id_produto
WHERE
    p.nome_produto = 'Dorflex'  -- Nome remedio/item da farmacia
GROUP BY
    e.lote, p.nome_produto, pm.preco, e.qtd_minima, pv.data_vencimento;


--- COMANDOS PARA A CONSULTA 6 ---

SELECT
    p.id_produto AS codigo,
    p.nome_produto AS nome,
    pm.marca_id_marca AS marca_id,
    m.nome_marca AS fabricante,
    COUNT(pi.id_pedido_item) AS qtd_vendas
FROM
    produto p
JOIN
    produto_marca pm ON p.id_produto = pm.produto_id_produto
JOIN
    pedido_item pi ON pm.marca_id_marca = pi.marca_id_marca AND pm.produto_id_produto = pi.produto_id_produto
JOIN
    pedido pe ON pi.pedido_id_pedido = pe.id_pedido
JOIN
    venda v ON pe.id_pedido = v.pedido_id_pedido
JOIN
    cidade c ON pe.cidade_id_pedido_cidade = c.id_cidade
JOIN
    marca m ON pm.marca_id_marca = m.id_marca
WHERE
    c.nome_cidade = 'São Paulo' -- o nome da Cidade
GROUP BY
    p.id_produto, p.nome_produto, pm.marca_id_marca, m.nome_marca
ORDER BY
    qtd_vendas DESC
LIMIT 10;


--- COMANDOS PARA A CONSULTA 7 ---

SELECT 
    f.nome AS farmacia,
    ci.nome_cidade AS cidade,
    ci.uf AS uf,
    p.nome_produto AS produto,
    m.nome_marca AS fabricante,
    SUM(pi.qtd_item) AS qtd_vendas
FROM 
    venda v
JOIN 
    pedido pe ON v.pedido_id_pedido = pe.id_pedido
JOIN 
    farmacia f ON v.farmacia_id = f.id
JOIN 
    cidade ci ON f.id = ci.id_cidade
JOIN 
    pedido_item pi ON pe.id_pedido = pi.pedido_id_pedido
JOIN 
    produto_marca pm ON pi.marca_id_marca = pm.marca_id_marca AND pi.produto_id_produto = pm.produto_id_produto
JOIN 
    produto p ON pm.produto_id_produto = p.id_produto
JOIN 
    marca m ON pm.marca_id_marca = m.id_marca
JOIN 
    plataforma pl ON pe.plataforma_id_plataforma_pedido = pl.id_plataforma
WHERE 
    p.nome_produto = 'Dorflex' AND
    ci.uf = 'SP' AND
    pl.ds_plataforma = 'aplicativo' AND
    v.data_venda >= CURDATE() - INTERVAL 30 DAY
GROUP BY 
    f.nome, ci.nome_cidade, ci.uf, p.nome_produto, m.nome_marca
ORDER BY 
    qtd_vendas DESC
LIMIT 10;

--- COMANDOS PARA A CONSULTA 8 ---

SELECT
    f.nome AS nome_farmacia,
    g.nome AS nome_gerente,
    g.telefone1 AS telefone_gerente,
    g.telefone2 AS telefone2_gerente,
    g.email AS email_gerente
FROM
    venda v
JOIN
    farmacia f ON v.farmacia_id = f.id
JOIN
    funcionario g ON f.gerente_id_funcionario = g.id_funcionario
WHERE
    v.pedido_id_pedido = (
        SELECT
            pi.pedido_id_pedido
        FROM
            pedido_item pi
        WHERE
            pi.produto_id_produto = 1
        ORDER BY
            pi.preco * pi.qtd_item
        LIMIT 1
    );

--- COMANDOS PARA A CONSULTA 9 ---

SELECT
    f.nome AS entregador,
    SUM(v.preco_venda) AS ticket_medio
FROM
    funcionario f
JOIN
    venda v ON f.id_funcionario = v.entregador_id_funcionario
JOIN
    pedido p ON v.pedido_id_pedido = p.id_pedido
JOIN
    plataforma pl ON p.plataforma_id_plataforma_pedido = pl.id_plataforma
WHERE
    f.id_funcionario = 6 -- Substitua pelo ID do funcionário desejado
    AND pl.ds_plataforma = 'aplicativo'
GROUP BY
    f.nome;

--- COMANDOS PARA CRIAÇÃO E EXEMPLO DE USO DA VIEW ---

CREATE VIEW vw_pedido_detalhado AS
SELECT
    p.id_pedido,
    c.nome AS cliente_nome,
    ps.status_nome AS status_pedido,
    pi.preco AS preco_item,
    pi.desconto AS desconto_item,
    m.nome_marca AS marca_produto,
    pr.nome_produto AS nome_produto,
    pi.qtd_item AS quantidade_item,
    pi.data_item AS data_item
FROM pedido p
JOIN cliente c ON p.cliente_id_cliente = c.id_cliente
JOIN pedido_status ps ON p.pedido_status_id_pedido_status = ps.id_pedido_status
JOIN pedido_item pi ON p.id_pedido = pi.pedido_id_pedido
JOIN produto_marca pm ON pi.marca_id_marca = pm.marca_id_marca
JOIN produto pr ON pi.produto_id_produto = pr.id_produto
JOIN marca m ON pm.marca_id_marca = m.id_marca;

--- COMANDOS PARA CRIAÇÃO E EXEMPLO DE USO DA FUNÇÃO ---

DELIMITER //

CREATE FUNCTION calcular_preco_total_pedido(pedido_id INT) RETURNS DOUBLE READS SQL DATA
BEGIN
    DECLARE total DOUBLE;

    SELECT SUM(preco - desconto) INTO total
    FROM pedido_item
    WHERE pedido_id_pedido = pedido_id;

    RETURN total;
END //

DELIMITER ;


--- COMANDOS PARA CRIAÇÃO E EXEMPLO DE USO DA STORED PROCEDURE ---
DELIMITER //

CREATE PROCEDURE processar_pedido(IN pedido_id INT)
BEGIN
    DECLARE total_pedido DOUBLE;

    SET total_pedido = calcular_preco_total_pedido(pedido_id);

    UPDATE pedido SET pedido_status_id_pedido_status = 2 WHERE id_pedido = pedido_id;

    INSERT INTO venda (pedido_id_pedido, data_venda, preco_venda) 
    VALUES (pedido_id, CURDATE(), total_pedido);
END //

DELIMITER ;

--- COMANDOS PARA CRIAÇÃO E EXEMPLO DE USO DA TRIGGER ---

DELIMITER //
CREATE TRIGGER after_insert_cliente
AFTER INSERT ON cliente FOR EACH ROW
BEGIN
    INSERT INTO log_cliente (acao, cliente_id, data_hora)
    VALUES ('Inserção de Cliente', NEW.id_cliente, NOW());
END;
//
DELIMITER ; 