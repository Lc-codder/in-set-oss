-- Criação da tabela de Autores
CREATE TABLE autores (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    nacionalidade VARCHAR(50),
    data_nascimento DATE
);

-- Criação da tabela de Livros
CREATE TABLE livros (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    autor_id INT NOT NULL,
    ano_publicacao INT CHECK (ano_publicacao > 1000 AND ano_publicacao <= EXTRACT(YEAR FROM CURRENT_DATE)),
    genero VARCHAR(50),
    descricao TEXT,
    disponibilidade BOOLEAN DEFAULT TRUE,  -- Assume que o livro está disponível por padrão
    FOREIGN KEY (autor_id) REFERENCES autores(id)
);

-- Criação da tabela de Usuários
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    data_cadastro DATE NOT NULL DEFAULT CURRENT_DATE
);

-- Criação da tabela de Empréstimos
CREATE TABLE emprestimos (
    id SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_livro INT NOT NULL,
    data_emprestimo DATE NOT NULL DEFAULT CURRENT_DATE,
    data_devolucao_prevista DATE NOT NULL,
    data_devolucao_real DATE,
    status VARCHAR(20) CHECK (status IN ('pendente', 'devolvido', 'atrasado')),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
    FOREIGN KEY (id_livro) REFERENCES livros(id),
    CHECK (data_devolucao_prevista > data_emprestimo)
);

-- Criação da tabela de Reservas
CREATE TABLE reservas (
    id SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_livro INT NOT NULL,
    data_reserva DATE NOT NULL DEFAULT CURRENT_DATE,
    status_reserva VARCHAR(20) CHECK (status_reserva IN ('pendente', 'reservado', 'cancelado')),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
    FOREIGN KEY (id_livro) REFERENCES livros(id)
);
