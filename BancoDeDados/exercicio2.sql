CREATE DATABASE eventos;

CREATE TABLE organizador (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    cnpj CHAR(14) NOT NULL UNIQUE
);

CREATE TABLE evento (
    id SERIAL PRIMARY KEY,
    nome_evento VARCHAR(100) NOT NULL,
    descricao TEXT,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    localizacao VARCHAR(100) NOT NULL,
    classificacao_idade_evento INT NOT NULL,
    organizador_id INT NOT NULL,
    FOREIGN KEY (organizador_id) REFERENCES organizador(id)
);

CREATE TABLE participante (
    id SERIAL PRIMARY KEY, 
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    telefone VARCHAR(20) NOT NULL, 
    data_inscricao DATE NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE
);

CREATE TABLE inscricoes (
    id SERIAL PRIMARY KEY,
    evento_id INT NOT NULL,
    participante_id INT NOT NULL,
    data_inscricao DATE NOT NULL,
    status_pagamento VARCHAR(20) NOT NULL CHECK (status_pagamento IN ('pendente', 'pago', 'cancelado')),
    tipo_inscricao VARCHAR(20) NOT NULL CHECK (tipo_inscricao IN ('meia-social', 'meia', 'inteira')),
    FOREIGN KEY (evento_id) REFERENCES evento(id),
    FOREIGN KEY (participante_id) REFERENCES participante(id),
    UNIQUE (evento_id, participante_id)
);
