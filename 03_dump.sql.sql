CREATE DATABASE IF NOT EXISTS TCK;
USE TCK;

-- Verifica se a tabela já existe antes de criar
CREATE TABLE IF NOT EXISTS cliente (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(255),
    telefone VARCHAR(255),
    email VARCHAR(255),
    idade INT,
    endereco VARCHAR(255),
    cliente_tipo INT
);

CREATE TABLE IF NOT EXISTS pedido_status (
    id_pedido_status INT PRIMARY KEY,
    status_nome VARCHAR(25) UNIQUE,
    descricao VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS produto_categoria (
    id_produto_categoria INT PRIMARY KEY,
    nome VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS produto_tipo (
    id_produto_tipo INT PRIMARY KEY,
    nome VARCHAR(255),
    id_produto_categoria INT,
    FOREIGN KEY (id_produto_categoria) REFERENCES produto_categoria(id_produto_categoria)
);

CREATE TABLE IF NOT EXISTS marca (
    id_marca INT PRIMARY KEY,
    marca VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS produto (
    id_produto INT PRIMARY KEY,
    produto_tipo_id INT,
    nome_produto VARCHAR(255),
    controlado TINYINT,
    FOREIGN KEY (produto_tipo_id) REFERENCES produto_tipo(id_produto_tipo)
);

CREATE TABLE IF NOT EXISTS produto_marca (
    marca_id_marca INT,
    produto_id_produto INT,
    preco DOUBLE,
    PRIMARY KEY (marca_id_marca, produto_id_produto),
    FOREIGN KEY (marca_id_marca) REFERENCES marca(id_marca),
    FOREIGN KEY (produto_id_produto) REFERENCES produto(id_produto)
);

CREATE TABLE IF NOT EXISTS pedido (
    id_pedido INT PRIMARY KEY,
    cliente_id_cliente INT,
    pedido_status VARCHAR(25),
    controlado TINYINT,
    FOREIGN KEY (cliente_id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (pedido_status) REFERENCES pedido_status(status_nome)
);

CREATE TABLE IF NOT EXISTS receita (
    id_receita INT PRIMARY KEY,
    beneficiario VARCHAR(25)
);

CREATE TABLE IF NOT EXISTS usuario_externo (
    id_usuario_externo INT PRIMARY KEY,
    cnpj VARCHAR(45),
    email VARCHAR(45),
    telefone VARCHAR(45)
);

CREATE TABLE IF NOT EXISTS fornecedor (
    id_fornecedor INT PRIMARY KEY,
    cnpj VARCHAR(45),
    nome_fantasia VARCHAR(45),
    razao_social VARCHAR(25)
);

CREATE TABLE IF NOT EXISTS venda (
    id_venda INT PRIMARY KEY,
    data_venda DATE,
    preco_venda DOUBLE,
    pedido_item_desconto DOUBLE,
    frete DOUBLE
);

CREATE TABLE IF NOT EXISTS pedido_itens (
    pedido_id_pedido INT PRIMARY KEY,
    preco DOUBLE,
    desconto DOUBLE,
    marca_id_marca INT,
    produto_id_produto INT,
    qtd_item INT,
    data_item DATE,
    FOREIGN KEY (pedido_id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (marca_id_marca) REFERENCES marca(id_marca),
    FOREIGN KEY (produto_id_produto) REFERENCES produto(id_produto)
);

CREATE TABLE IF NOT EXISTS funcionario (
    id_funcionario INT PRIMARY KEY,
    nome VARCHAR(255),
    cpf VARCHAR(255),
    cargo INT
);

CREATE TABLE IF NOT EXISTS papel (
    id_cargo INT PRIMARY KEY,
    ds_cargo VARCHAR(45)
);

CREATE TABLE IF NOT EXISTS estoque (
    fornecedor_id_fornecedor INT PRIMARY KEY,
    produto_marca_id_marca INT,
    preco DOUBLE,
    qtd_minima DOUBLE,
    produto_marca_id_produto INT,
    lote INT,
    FOREIGN KEY (fornecedor_id_fornecedor) REFERENCES fornecedor(id_fornecedor),
    FOREIGN KEY (produto_marca_id_marca) REFERENCES marca(id_marca),
    FOREIGN KEY (produto_marca_id_produto) REFERENCES produto(id_produto)
);

CREATE TABLE IF NOT EXISTS produto_categoria (
    id_produto_categoria INT PRIMARY KEY,
    nome VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS produto_tipo (
    id_produto_tipo INT PRIMARY KEY,
    nome VARCHAR(255),
    id_produto_categoria INT,
    FOREIGN KEY (id_produto_categoria) REFERENCES produto_categoria(id_produto_categoria)
);

CREATE TABLE IF NOT EXISTS produto (
    id_produto INT PRIMARY KEY,
    produto_tipo_id INT,
    nome_produto VARCHAR(255),
    controlado TINYINT,
    FOREIGN KEY (produto_tipo_id) REFERENCES produto_tipo(id_produto_tipo)
);

-- Cliente
INSERT INTO cliente (id_cliente, nome, telefone, email, idade, endereco, cliente_tipo) VALUES
(1, 'João Silva', '123456789', 'joao.silva@email.com', 30, 'Rua A, 123', 1),
(2, 'Maria Oliveira', '987654321', 'maria.oliveira@email.com', 25, 'Avenida B, 456', 2),
(3, 'Carlos Santos', '111222333', 'carlos.santos@email.com', 40, 'Travessa C, 789', 1),
(4, 'Ana Pereira', '999888777', 'ana.pereira@email.com', 35, 'Rua D, 321', 2),
(5, 'Pedro Costa', '444555666', 'pedro.costa@email.com', 28, 'Avenida E, 654', 1);

-- Pedido Status
INSERT INTO pedido_status (id_pedido_status, status_nome, descricao) VALUES
(1, 'Em andamento', 'Pedido em andamento'),
(2, 'Concluído', 'Pedido concluído'),
(3, 'Cancelado', 'Pedido cancelado');

-- Produto Categoria
INSERT INTO produto_categoria (id_produto_categoria, nome) VALUES
(1, 'Medicamento'),
(2, 'Higiene Pessoal'),
(3, 'Perfumaria');

-- Produto Tipo
INSERT INTO produto_tipo (id_produto_tipo, nome, id_produto_categoria) VALUES
(1, 'Analgésico', 1),
(2, 'Shampoo', 2),
(3, 'Perfume', 3),
(4, 'Antibiótico', 1),
(5, 'Sabonete', 2);

-- Marca
INSERT INTO marca (id_marca, marca) VALUES
(1, 'Genérico'),
(2, 'Johnson & Johnson'),
(3, 'Natura'),
(4, 'Bayer'),
(5, 'Dove');

-- Produto
INSERT INTO produto (id_produto, produto_tipo_id, nome_produto, controlado) VALUES
(1, 1, 'Dorflex', 1),
(2, 2, 'Pantene', 0),
(3, 3, 'Amó, Eu', 0),
(4, 4, 'Ciprofloxacino', 1),
(5, 5, 'Nivea', 0);

-- Produto Marca
INSERT INTO produto_marca (marca_id_marca, produto_id_produto, preco) VALUES
(1, 1, 10.99),
(2, 2, 15.50),
(3, 3, 80.00),
(4, 4, 25.99),
(5, 5, 8.75);

-- Pedido
INSERT INTO pedido (id_pedido, cliente_id_cliente, pedido_status, controlado) VALUES
(1, 1, 'Em andamento', 0),
(2, 2, 'Concluído', 1),
(3, 3, 'Em andamento', 0),
(4, 4, 'Concluído', 1),
(5, 5, 'Cancelado', 0);

-- Receita
INSERT INTO receita (id_receita, beneficiario) VALUES
(1, 'João Silva'),
(2, 'Maria Oliveira'),
(3, 'Carlos Santos'),
(4, 'Ana Pereira'),
(5, 'Pedro Costa');

-- Usuario Externo
INSERT INTO usuario_externo (id_usuario_externo, cnpj, email, telefone) VALUES
(1, '12345678901234', 'usuario.externo@email.com', '9876543210'),
(2, '56789012345678', 'outro.usuario@email.com', '1234567890'),
(3, '90123456789012', 'mais.um@email.com', '3456789012'),
(4, '34567890123456', 'usuario.quatro@email.com', '7890123456'),
(5, '67890123456789', 'ultimo.usuario@email.com', '2345678901');

-- Fornecedor
INSERT INTO fornecedor (id_fornecedor, cnpj, nome_fantasia, razao_social) VALUES
(1, '98765432109876', 'FarmaPlus', 'FarmaPlus LTDA'),
(2, '65432109876543', 'Biolab', 'Biolab S.A.'),
(3, '21098765432109', 'Drogasil', 'Drogasil Distribuidora'),
(4, '89012345678901', 'PharmaCorp', 'PharmaCorp Indústria'),
(5, '23456789012345', 'UltraFarma', 'UltraFarma Ltda.');

-- Venda
INSERT INTO venda (id_venda, data_venda, preco_venda, pedido_item_desconto, frete) VALUES
(1, '2023-01-15', 50.00, 5.00, 7.50),
(2, '2023-02-20', 120.00, 10.00, 12.00),
(3, '2023-03-25', 30.00, 2.50, 5.00),
(4, '2023-04-10', 80.00, 7.00, 8.50),
(5, '2023-05-05', 15.00, 1.50, 3.00);

-- Pedido Itens
INSERT INTO pedido_itens (pedido_id_pedido, preco, desconto, marca_id_marca, produto_id_produto, qtd_item, data_item) VALUES
(1, 10.99, 1.00, 1, 1, 3, '2023-01-15'),
(2, 15.50, 2.00, 2, 2, 2, '2023-02-20'),
(3, 80.00, 5.00, 3, 3, 1, '2023-03-25'),
(4, 25.99, 3.00, 4, 4, 4, '2023-04-10'),
(5, 8.75, 0.75, 5, 5, 5, '2023-05-05');

-- Funcionario
INSERT INTO funcionario (id_funcionario, nome, cpf, cargo) VALUES
(1, 'Julia Souza', '123.456.789-01', 1),
(2, 'Lucas Oliveira', '234.567.890-12', 2),
(3, 'Beatriz Santos', '345.678.901-23', 1),
(4, 'Rafael Costa', '456.789.012-34', 3),
(5, 'Fernanda Lima', '567.890.123-45', 2);

-- Papel
INSERT INTO papel (id_cargo, ds_cargo) VALUES
(1, 'Atendente'),
(2, 'Gerente'),
(3, 'Administrador');

-- Estoque
INSERT INTO estoque (fornecedor_id_fornecedor, produto_marca_id_marca, preco, qtd_minima, produto_marca_id_produto, lote) VALUES
(1, 1, 10.99, 20.0, 1, 12345),
(2, 2, 15.50, 15.0, 2, 54321),
(3, 3, 80.00, 5.0, 3, 98765),
(4, 4, 25.99, 10.0, 4, 45678),
(5, 5, 8.75, 25.0, 5, 87654);

-- Consulta para exibir todos os elementos de todas as tabelas
SELECT * FROM cliente;
SELECT * FROM pedido_status;
SELECT * FROM produto_categoria;
SELECT * FROM produto_tipo;
SELECT * FROM marca;
SELECT * FROM produto;
SELECT * FROM produto_marca;
SELECT * FROM pedido;
SELECT * FROM receita;
SELECT * FROM usuario_externo;
SELECT * FROM fornecedor;
SELECT * FROM venda;
SELECT * FROM pedido_itens;
SELECT * FROM funcionario;
SELECT * FROM papel;
SELECT * FROM estoque;