-- Criacao da tabela de clientes
CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome_cliente VARCHAR(100),
    email VARCHAR(100),
    telefone VARCHAR(15),
    endereco VARCHAR(255),
    tipo_cliente ENUM('PF', 'PJ'),
    cpf VARCHAR(14),
    cnpj VARCHAR(18),
    data_cadastro DATE
);

-- Criacao da tabela de fornecedores
CREATE TABLE Fornecedor (
    id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    nome_fornecedor VARCHAR(100),
    endereco_fornecedor VARCHAR(255),
    telefone_fornecedor VARCHAR(15),
    email_fornecedor VARCHAR(100)
);

-- Criacao da tabela de produtos
CREATE TABLE Produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(100),
    descricao_produto TEXT,
    preco DECIMAL(10,2),
    quantidade_estoque INT,
    id_fornecedor INT,
    categoria_produto VARCHAR(50),
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedor(id_fornecedor)
);

-- Criacao da tabela de pedidos
CREATE TABLE Pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    data_pedido DATE,
    valor_total DECIMAL(10,2),
    status_pedido ENUM('Em processamento', 'Enviado', 'Entregue', 'Cancelado'),
    data_entrega DATE,
    id_vendedor INT,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES Vendedor(id_vendedor)
);

-- Criacao da tabela de produto-pedido
CREATE TABLE Produto_Pedido (
    id_produto INT,
    id_pedido INT,
    quantidade_produto INT,
    preco_unitario DECIMAL(10,2),
    PRIMARY KEY (id_produto, id_pedido),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido)
);

-- Criacao da tabela de pagamentos
CREATE TABLE Pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_cliente INT,
    data_pagamento DATE,
    valor_pago DECIMAL(10,2),
    metodo_pagamento ENUM('Cartao de Credito', 'Boleto', 'Pix'),
    status_pagamento ENUM('Pago', 'Pendente', 'Cancelado'),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- Criacao da tabela de entregas
CREATE TABLE Entrega (
    id_entrega INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    status_entrega ENUM('Em Rota', 'Entregue', 'Atrasado'),
    codigo_rastreio VARCHAR(50),
    data_envio DATE,
    data_entrega DATE,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido)
);

-- Criacao da tabela de vendedores
CREATE TABLE Vendedor (
    id_vendedor INT AUTO_INCREMENT PRIMARY KEY,
    nome_vendedor VARCHAR(100),
    email_vendedor VARCHAR(100),
    telefone_vendedor VARCHAR(15)
);

-- Inserir um cliente PF
INSERT INTO Cliente (nome_cliente, email, telefone, endereco, tipo_cliente, cpf, data_cadastro) 
VALUES ('Joao da Silva', 'joao@example.com', '1234567890', 'Rua A, 123', 'PF', '12345678901', '2024-11-18');

-- Inserir um fornecedor
INSERT INTO Fornecedor (nome_fornecedor, endereco_fornecedor, telefone_fornecedor, email_fornecedor)
VALUES ('Fornecedor ABC', 'Rua B, 456', '0987654321', 'abc@fornecedor.com');

-- Inserir um produto
INSERT INTO Produto (nome_produto, descricao_produto, preco, quantidade_estoque, id_fornecedor, categoria_produto)
VALUES ('Produto 1', 'Descricao do Produto 1', 50.00, 100, 1, 'Eletronicos');

-- Inserir um vendedor
INSERT INTO Vendedor (nome_vende
dor, email_vendedor, telefone_vendedor)
VALUES ('Maria Oliveira', 'maria@vendedor.com', '9876543210');

SELECT 
    c.nome_cliente, 
    COUNT(p.id_pedido) AS total_pedidos
FROM Cliente c
JOIN Pedido p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente;

SELECT DISTINCT v.nome_vendedor

FROM Vendedor v
JOIN Fornecedor f ON v.nome_vendedor = f.nome_fornecedor;

SELECT 
    p.nome_produto, 
    f.nome_fornecedor, 
    p.quantidade_estoque
FROM Produto p
JOIN Fornecedor f ON p.id_fornecedor = f.id_fornecedor;

SELECT 
    f.nome_fornecedor, 
    p.nome_produto
FROM Produto p
JOIN Fornecedor f ON p.id_fornecedor = f.id_fornecedor;

SELECT 
    nome_produto, 
    preco
FROM Produto
WHERE preco > (SELECT AVG(preco) FROM Produto);

# Sistema de E-commerce

Este projeto visa modelar e implementar um banco de dados para um sistema de e-commerce. O banco de dados contém as seguintes entidades: Cliente, Produto, Fornecedor, Pedido, Pagamento, Entrega e Vendedor. O objetivo é gerenciar as informações relacionadas a clientes, produtos, pedidos, pagamentos, entregas e fornecedores.

## Estrutura do Banco de Dados

As tabelas do banco de dados incluem:

- **Cliente**: Informacoes sobre os clientes (Pessoa Fisica ou Juridica).
- **Produto**: Informacoes sobre os produtos vendidos.
- **Fornecedor**: Informacoes sobre os fornecedores de produtos.
- **Pedido**: Relacionamento entre clientes e os pedidos feitos.
- **Pagamento**: Informacoes sobre os pagamentos realizados pelos clientes.
- **Entrega**: Informacoes sobre o status e rastreio das entregas.
- **Vendedor**: Informacoes sobre os vendedores responsaveis pelos pedidos.

## Consultas SQL

Algumas das principais consultas realizadas no banco de dados incluem:

- Quantidade de pedidos por cliente.
- Relacao entre vendedores e fornecedores.
- Relacionamento entre produtos, fornecedores e estoques.
- Produtos com valores acima da media de preco.


