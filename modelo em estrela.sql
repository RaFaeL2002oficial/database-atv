-- Tabelas de Dimensão
CREATE TABLE Dim_Cliente (
    codigo_cliente INT PRIMARY KEY,
    nome_cliente VARCHAR(150),
    cpf_cliente VARCHAR(14),
    email_cliente VARCHAR(45),
    telefone_cliente VARCHAR(45)
);

CREATE TABLE Dim_Ano_Mes_Dia (
    data DATE PRIMARY KEY,
    ano INT,
    mes INT,
    dia INT
);

CREATE TABLE Dim_Prato (
    codigo_prato INT PRIMARY KEY,
    nome_prato VARCHAR(45),
    codigo_tipo_prato INT,
    descricao_prato TEXT,
    categoria_prato VARCHAR(45),
    disponibilidade BOOLEAN DEFAULT TRUE,
    ingredientes TEXT,
    calorias INT,
    tempo_preparo INT,
    imagem_prato VARCHAR(255),
    FOREIGN KEY (codigo_tipo_prato) REFERENCES tb_tipo_prato(codigo_tipo_prato)
);

CREATE TABLE Dim_Situacao_Pedido (
    codigo_situacao_pedido INT PRIMARY KEY,
    nome_situacao_pedido VARCHAR(45)
);

-- Tabela de Fato
CREATE TABLE Fato_Pedido (
    codigo_pedido INT PRIMARY KEY,
    codigo_cliente INT,
    codigo_prato INT,
    codigo_situacao_pedido INT,
    data_pedido DATE,
    valor_total_pedido DECIMAL(10, 2),
    valor_unitario_prato DECIMAL(10, 2),
    quantidade INT,
    FOREIGN KEY (codigo_cliente) REFERENCES Dim_Cliente(codigo_cliente),
    FOREIGN KEY (codigo_prato) REFERENCES Dim_Prato(codigo_prato),
    FOREIGN KEY (codigo_situacao_pedido) REFERENCES Dim_Situacao_Pedido(codigo_situacao_pedido),
    FOREIGN KEY (data_pedido) REFERENCES Dim_Ano_Mes_Dia(data)
);
