create database biblioteca;
use biblioteca;

create table autor(
id int auto_increment primary key,
nome varchar(50) not null,
nacionalidade varchar(50) not null,
data_nascimento date not null,
cnpj CHAR(14) NOT NULL UNIQUE
);
create table usuario(
id int auto_increment primary key,
nome varchar(50) not null,
email varchar(50) not null unique,
telefone varchar(20) NOT NULL,
data_cadastro date not null,
cpf varchar(11) not null unique
);
create table livro (
id int auto_increment primary key,
titulo varchar(50) not null,
ano_publicado date not null,
genero varchar(25) not null,
descricao varchar(300),
disponibilidade boolean default true,
classificacao ENUM('L', '10', '12', '14', '16', '18'),
autor_id int not null,
FOREIGN KEY (autor_id) REFERENCES autor(id)
);

create table emprestimos(
id int auto_increment primary key,
data_emprestimo date not null,
data_prevista date not null,
data_entrega TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
status_entrega ENUM('entregue', 'atrasado', 'adiantado'),
multa decimal,
usuario_id int not null,
livro_id int not null,
foreign key (livro_id) references livro(id),
foreign key (usuario_id) references usuario(id)
);

create table reserva(
id int auto_increment primary key,
usuario_id int not null,
livro_id int not null,
data_reserva date not null,
status_reserva ENUM ('reservado', 'alugado', 'disponivel'),
observacoes text, 
foreign key (livro_id) references livro(id),
foreign key (usuario_id) references usuario(id)
);

INSERT INTO autor (nome, nacionalidade, data_nascimento, cnpj) VALUES
('Lucas daniel', 'Brasileiro', '2005-07-18', '67308195000102'), -- familia 
('Pedro Guimaraes', 'Brasileiro', '1962-12-22', '67510429000108'), -- familia 
('Claudia Adriana', 'Brasileiro', '1968-10-02', '29357418000132'), -- familia 
('Joao Guimaraes', 'Brasileiro', '1999-01-04', '06328475000195'), -- familia 
('Pedro Henrique', 'Brasileiro', '1997-05-08', '49621534000162'), -- familia 
('Elaine Cristina', 'Brasileiro', '1950-05-03', '39687132000110'), -- familia 
('Miltom nascimento', 'Português', '1967-01-07', '91843067000166'), -- familia 
('rosalina silva', 'Português', '1972-10-22', '16894273000147'), -- familia 
('Dolair dias', 'Brasileiro', '1950-02-03', '61032860000190'), -- familia 
('Iranice de Jeus', 'Português', '1958-05-20', '91768421000124'), -- familia 
('Amanda castro', 'Cabo-verdiano', '1966-09-14', '28473618000199'), -- familia 
('Benicio lucca', 'Angolano', '1978-06-04', '32789475000139'), -- familia 
('Rafael Teixeira', 'Brasileiro', '1956-08-27', '57163029000159'),
('Vitória Azevedo', 'Moçambicano', '1963-04-12', '82413057000102'),
('Fábio Duarte', 'Português', '1954-11-10', '29576843000164'),
('Isabela Almeida', 'Angolano', '1961-02-28', '10892735000146'),
('Marcelo Figueiredo', 'Cabo-verdiano', '1977-12-05', '46321897000186'),
('Fernanda Pinto', 'Angolano', '1970-03-21', '20764158000128'),
('Tatiane Costa', 'Angolano', '1968-10-18', '79054361000166'),
('Gustavo Ribeiro', 'Português', '1955-01-23', '34298712000108'),
('Paula Fernandes', 'Brasileiro', '1951-06-30', '62037189000193'),
('Marcos Vinícius', 'Cabo-verdiano', '1969-07-19', '28743592000140'),
('Letícia Barros', 'Angolano', '1974-09-03', '50897342000137'),
('Renato Gonçalves', 'Brasileiro', '1953-04-11', '73926184000172'),
('Amanda Lopes', 'Português', '1957-11-29', '14389267000122'),
('Carolina Oliveira', 'Moçambicano', '1976-01-09', '97453812000101'),
('João Paulo Mendes', 'Cabo-verdiano', '1950-08-13', '32987416000192'),
('Viviane Cardoso', 'Angolano', '1962-12-26', '83914728000146'),
('Felipe Araújo', 'Brasileiro', '1965-09-06', '16309258000111'),
('Bruna Neves', 'Português', '1973-03-15', '26893175000174'),
('Lucas Santana', 'Cabo-verdiano', '1979-02-02', '97041325000134'),
('Mirela Antunes', 'Angolano', '1971-06-17', '50493827000158'),
('André Ferreira', 'Moçambicano', '1952-10-07', '39847215000127'),
('Larissa Silva', 'Brasileiro', '1959-03-24', '63184792000185'),
('Diego Freitas', 'Português', '1960-07-08', '20493875000198'),
('Eduardo Lima', 'Cabo-verdiano', '1970-11-01', '68419327000100'),
('Priscila Soares', 'Angolano', '1976-04-05', '84723196000167'),
('Rodrigo Martins', 'Brasileiro', '1964-08-12', '72390548000189'),
('Nathalia Pires', 'Moçambicano', '1977-05-16', '15829374000142'),
('Camilo Andrade', 'Português', '1966-06-23', '24678193000111');

INSERT INTO usuario (nome, email, telefone, data_cadastro, cpf) VALUES
('Pedro Paulo', 'Pedropaulo@email.com', '11 5003 2466', '2024-05-01', '43917528673'), -- conhecidos
('Rafael Hermes', 'Rafahermes@email.com', '21 3775 1116', '2025-01-20', '18095734241'), -- conhecidos
('Paulo isaque', 'PIademicon@email.com', '21 2918 9508', '2021-09-06', '50128974630'), -- conhecidos
('Daniel queiroz', 'Danielroz@email.com', '71 5319 0098', '2021-03-13', '72350196461'), -- conhecidos
('Maria julia', 'maju77@email.com', '71 9926 0237', '2021-11-29', '63197824040'), -- conhecidos
('giovanna campos', 'gicampelo@email.com', '31 7149 1989', '2024-10-21', '14375089288'), -- conhecidos
('Tiago fourex', 'foureaxTT@email.com', '21 0905 5429', '2023-08-03', '29048536774'), -- conhecidos
('Gabriel Tenorio', 'zetenoirio@email.com', '41 0358 0188', '2021-01-05', '98036157268'), -- conhecidos
('Sarah paulista', 'sarinhaSP@email.com', '71 6976 2098', '2024-12-06', '18937025612'), -- conhecidos
('Joao calazans', 'jumpzion35@email.com', '31 4413 2537', '2020-08-23', '02481693506'), -- conhecidos
('bia Calazans', 'calazansbia@email.com', '27 5297 0084', '2023-03-11', '83620951460'), -- conhecidos
('Matheus Lessa', 'Matheuslessa@email.com', '41 9140 2339', '2022-07-30', '34860157213'), -- conhecidos
('Gabriel Farias', 'carolinafreitas@email.com', '85 4704 8441', '2023-06-28', '10583694720'),
('Isabela da Rosa', 'matheus79@email.com', '21 9836 2106', '2022-01-19', '51847039671'),
('Eduarda Ferreira', 'diego16@email.com', '51 3130 4096', '2021-12-02', '91047265842'),
('Fernando Moreira', 'emanuelly56@email.com', '11 2129 4963', '2023-09-07', '36784925193'),
('Camila Lopes', 'yuri84@email.com', '11 9281 9756', '2024-04-15', '13468905267'),
('Rafael Correia', 'tatiane.moura@email.com', '61 9023 0325', '2021-06-09', '94517620834'),
('Tatiane Gonçalves', 'lara85@email.com', '85 5589 7009', '2022-10-20', '31085746902'),
('Gabriela Ribeiro', 'vitoria82@email.com', '31 9632 9985', '2020-07-01', '25890361742'),
('Murilo da Mata', 'arthur93@email.com', '41 9936 4390', '2024-03-27', '60291387421'),
('Thais Cardoso', 'renanbarros@email.com', '51 9004 7822', '2022-12-09', '15378092467'),
('Alex Monteiro', 'alexmonteiro@email.com', '91 9233 1826', '2023-10-11', '84912673580'),
('Rebeca Rocha', 'rodrigo.souza@email.com', '75 9128 3746', '2023-01-16', '73180592416'),
('Yasmin de Azevedo', 'yasmin12@email.com', '71 9224 8179', '2020-06-15', '97032854176'),
('Carlos Alberto', 'eduardo70@email.com', '21 9952 8821', '2021-05-20', '17894265013'),
('Lucas Viana', 'lucasviana@email.com', '71 9981 0730', '2022-03-07', '83927465029'),
('Letícia Moura', 'leticia.moura@email.com', '85 9422 3793', '2023-11-04', '45367198201'),
('Beatriz Teixeira', 'beatriz.teixeira@email.com', '41 9974 1998', '2020-10-30', '10247953826'),
('André Barros', 'andrebarros@email.com', '62 9785 2863', '2023-05-25', '59687243167'),
('Helena da Luz', 'helenadaluz@email.com', '71 9884 4317', '2024-01-12', '74918365014'),
('Matheus Castro', 'matheus.castro@email.com', '47 9649 2741', '2022-08-18', '68124075982'),
('Juliana Fernandes', 'julianafernandes@email.com', '81 9908 1044', '2021-02-28', '19246857301'),
('Samuel Mendes', 'samuelmendes@email.com', '31 9987 6250', '2023-07-19', '84729651003'),
('Nicole Nogueira', 'nicolenogueira@email.com', '48 9977 3011', '2020-11-14', '30984712645'),
('Pedro Henrique Lima', 'pedrohenrique@email.com', '51 9966 8804', '2023-09-09', '47891236074'),
('Ana Luísa Figueiredo', 'analuisa.fig@email.com', '71 9112 7840', '2021-04-22', '68123075496'),
('Daniela da Paz', 'daniela.paz@email.com', '85 9051 9933', '2022-05-14', '90178523617'),
('Vinícius Souza', 'viniciussouza@email.com', '34 9346 4799', '2024-02-17', '51820649731'),
('Camilo Monteiro', 'joana39@email.com', '71 3865 5029', '2022-04-25', '98573021402');

INSERT INTO livro (titulo, ano_publicado, genero, descricao, disponibilidade, classificacao, autor_id) VALUES
('O Nome do Vento', '2007-03-27', 'Fantasia', 'A lendária história do mago Kvothe contada por ele mesmo.', true, '14', 25),
('A Arte da Guerra', '0005-01-01', 'Estratégia', 'Tratado militar chinês com aplicações modernas.', true, 'L', 36),
('O Silêncio dos Inocentes', '1988-08-01', 'Suspense', 'Agente do FBI consulta serial killer para capturar outro.', true, '18', 19),
('Duna', '1965-08-01', 'Ficção Científica', 'Epopeia interplanetária sobre política, religião e ecologia.', true, '14', 5),
('Matilda', '1988-10-01', 'Infantil', 'Menina com poderes enfrenta pais e diretora tirânicos.', true, 'L', 26),
('O Amor nos Tempos do Cólera', '1985-03-01', 'Romance', 'História de amor que dura décadas na América Latina.', true, '16', 17),
('A Mão Esquerda da Escuridão', '1969-03-01', 'Ficção Científica', 'Exploração de gênero numa sociedade alienígena.', true, '14', 3),
('Percy Jackson e o Ladrão de Raios', '2005-06-28', 'Juvenil', 'Garoto descobre ser filho de Poseidon na América moderna.', true, '10', 34),
('O Guia do Mochileiro das Galáxias', '1979-10-12', 'Ficção Científica', 'Comédia sobre o fim da Terra e aventuras espaciais.', true, '12', 7),
('Dom Casmurro', '1899-01-01', 'Romance', 'A eterna dúvida sobre o ciúme e a traição na obra-prima de Machado de Assis.', true, '12', 4),
('Norwegian Wood', '1987-09-04', 'Romance', 'Melancólica história de amor e perda no Japão dos anos 60.', false, '16', 29),
('O Poder do Hábito', '2012-02-28', 'Autoajuda', 'Como hábitos funcionam e como transformá-los.', true, 'L', 28),
('Harry Potter e a Pedra Filosofal', '1997-06-26', 'Fantasia', 'O menino bruxo descobre seu destino em Hogwarts.', true, '10', 14),
('A Culpa é das Estrelas', '2012-01-10', 'Romance', 'Dois adolescentes com câncer se apaixonam numa jornada emocionante.', true, '12', 23),
('Breves Respostas para Grandes Questões', '2018-10-16', 'Ciência', 'Últimas reflexões de Stephen Hawking sobre o universo.', false, 'L', 21),
('O Hobbit', '1937-09-21', 'Infantil', 'Bilbo Bolseiro na jornada para recuperar o tesouro dos dragões.', true, '10', 9),
('Garota Exemplar', '2012-06-05', 'Suspense', 'Desaparecimento de mulher revela casamento perturbador.', true, '16', 27),
('Cem Anos de Solidão', '1967-05-30', 'Romance', 'Realismo mágico que narra a família Buendía em Macondo.', false, '14', 17),
('O Iluminado', '1977-01-28', 'Terror', 'Família isolada em hotel com forças sobrenaturais.', true, '16', 30),
('Os Homens que Não Amavam as Mulheres', '2005-08-01', 'Suspense', 'Jornalista e hacker investigam desaparecimento nos anos 60.', true, '18', 20),
('Terramar', '1968-01-01', 'Fantasia', 'A jornada de um jovem para se tornar arquimago.', false, '12', 2),
('Drácula', '1897-05-26', 'Terror', 'Clássico sobre o vampiro da Transilvânia.', true, '14', 1),
('Assassinato no Expresso do Oriente', '1934-01-01', 'Mistério', 'Hercule Poirot resolve crime em trem preso na neve.', true, '12', 10),
('O Pequeno Príncipe', '1943-04-06', 'Infantil', 'Filosófica história do principezinho e sua rosa.', true, 'L', 32),
('Orgulho e Preconceito', '1813-01-28', 'Romance', 'História de Elizabeth Bennet e Mr. Darcy na sociedade inglesa.', true, 'L', 8),
('Sapiens: Uma Breve História da Humanidade', '2011-02-10', 'História', 'Trajetória do Homo sapiens desde a África.', true, '12', 33),
('A Roda do Tempo: O Olho do Mundo', '1990-01-15', 'Fantasia', 'Jovens do interior são lançados num conflito cósmico.', true, '14', 18),
('Persuasão', '1817-12-20', 'Romance', 'Última obra completa de Jane Austen sobre segundas chances no amor.', true, 'L', 8),
('It: A Coisa', '1986-09-15', 'Terror', 'Palhaço demoníaco aterroriza crianças em Derry.', true, '18', 16),
('O Código Da Vinci', '2003-03-18', 'Mistério', 'Professor desvenda conspiração religiosa em Paris.', false, '14', 13),
('Androides Sonham com Ovelhas Elétricas?', '1968-01-01', 'Ficção Científica', 'Inspiração para Blade Runner, explora o que é ser humano.', true, '14', 22),
('O Senhor dos Anéis: A Sociedade do Anel', '1954-07-29', 'Fantasia', 'Início da jornada para destruir o Um Anel na Terra-Média.', true, '12', 9),
('As Crônicas de Nárnia', '1950-10-16', 'Fantasia', 'Aventuras mágicas através de um guarda-roupa.', false, 'L', 6),
('Neuromancer', '1984-07-01', 'Ficção Científica', 'Fundador do cyberpunk com hackers e inteligência artificial.', true, '16', 11),
('O Morro dos Ventos Uivantes', '1847-12-01', 'Romance', 'Clássico sobre amor obsessivo e vingança na Inglaterra rural.', true, '14', 12),
('Fundação', '1951-05-01', 'Ficção Científica', 'Queda de um império galáctico e a ciência da psicohistória.', false, '12', 15),
('A Fantástica Fábrica de Chocolate', '1964-01-17', 'Infantil', 'Tour mágico pela fábrica do excêntrico Willy Wonka.', false, 'L', 26),
('Cemitério de Navios', '2020-08-15', 'Reportagem', 'Investigação sobre o tráfico humano na Ásia.', true, '16', 35),
('O Exorcista', '1971-05-01', 'Terror', 'Possessão demoníaca e batalha entre fé e mal.', false, '18', 24),
('Snow Crash', '1992-06-01', 'Ficção Científica', 'Hacker entregador de pizza enfrenta vírus virtual.', false, '16', 31);

INSERT INTO emprestimos (data_emprestimo, data_prevista, data_entrega, status_entrega, multa, usuario_id, livro_id) VALUES
('2023-01-05', '2023-01-19', '2023-01-18 14:23:10', 'adiantado', NULL, 3, 12),
('2023-01-07', '2023-01-21', '2023-01-22 09:15:33', 'atrasado', 12.50, 8, 25),
('2023-01-10', '2023-01-24', '2023-01-24 16:45:00', 'entregue', NULL, 15, 7),
('2023-01-12', '2023-01-26', '2023-01-25 11:20:15', 'adiantado', NULL, 22, 33),
('2023-01-15', '2023-01-29', '2023-01-30 17:30:45', 'atrasado', 15.00, 5, 18),
('2023-01-18', '2023-02-01', '2023-02-01 10:00:00', 'entregue', NULL, 11, 29),
('2023-01-20', '2023-02-03', '2023-02-05 14:55:20', 'atrasado', 20.00, 19, 4),
('2023-01-22', '2023-02-05', '2023-02-04 13:10:30', 'adiantado', NULL, 7, 21),
('2023-01-25', '2023-02-08', '2023-02-08 09:45:00', 'entregue', NULL, 14, 36),
('2023-01-28', '2023-02-11', '2023-02-12 18:20:10', 'atrasado', 10.00, 27, 9),
('2023-02-01', '2023-02-15', '2023-02-14 15:30:00', 'adiantado', NULL, 2, 14),
('2023-02-03', '2023-02-17', '2023-02-18 11:45:22', 'atrasado', 12.50, 9, 27),
('2023-02-05', '2023-02-19', '2023-02-19 16:00:00', 'entregue', NULL, 16, 3),
('2023-02-08', '2023-02-22', '2023-02-21 10:15:45', 'adiantado', NULL, 23, 19),
('2023-02-10', '2023-02-24', '2023-02-25 14:30:10', 'atrasado', 15.00, 6, 31),
('2023-02-12', '2023-02-26', '2023-02-26 09:00:00', 'entregue', NULL, 12, 8),
('2023-02-15', '2023-03-01', '2023-03-03 17:45:30', 'atrasado', 25.00, 18, 22),
('2023-02-18', '2023-03-04', '2023-03-03 13:20:15', 'adiantado', NULL, 4, 35),
('2023-02-20', '2023-03-06', '2023-03-06 10:30:00', 'entregue', NULL, 21, 11),
('2023-02-22', '2023-03-08', '2023-03-09 19:10:45', 'atrasado', 10.00, 10, 26),
('2023-03-01', '2023-03-15', '2023-03-14 14:25:00', 'adiantado', NULL, 13, 1),
('2023-03-03', '2023-03-17', '2023-03-18 11:40:22', 'atrasado', 12.50, 20, 16),
('2023-03-05', '2023-03-19', '2023-03-19 15:55:00', 'entregue', NULL, 1, 23),
('2023-03-08', '2023-03-22', '2023-03-21 09:10:45', 'adiantado', NULL, 17, 30),
('2023-03-10', '2023-03-24', '2023-03-25 13:25:10', 'atrasado', 15.00, 24, 5),
('2023-03-12', '2023-03-26', '2023-03-26 08:45:00', 'entregue', NULL, 28, 17),
('2023-03-15', '2023-03-29', '2023-03-31 16:50:30', 'atrasado', 30.00, 25, 10),
('2023-03-18', '2023-04-01', '2023-03-31 12:15:15', 'adiantado', NULL, 30, 28),
('2023-03-20', '2023-04-03', '2023-04-03 09:30:00', 'entregue', NULL, 31, 13),
('2023-03-22', '2023-04-05', '2023-04-06 18:05:45', 'atrasado', 10.00, 32, 20),
('2023-04-01', '2023-04-15', '2023-04-14 13:20:00', 'adiantado', NULL, 33, 2),
('2023-04-03', '2023-04-17', '2023-04-18 10:35:22', 'atrasado', 12.50, 29, 15),
('2023-04-05', '2023-04-19', '2023-04-19 14:50:00', 'entregue', NULL, 35, 24),
('2023-04-08', '2023-04-22', '2023-04-21 08:05:45', 'adiantado', NULL, 26, 32),
('2023-04-10', '2023-04-24', '2023-04-25 12:20:10', 'atrasado', 15.00, 34, 6),
('2023-04-12', '2023-04-26', '2023-04-26 07:40:00', 'entregue', NULL, 37, 34),
('2023-04-15', '2023-04-29', '2023-05-01 15:55:30', 'atrasado', 25.00, 38, 37),
('2023-04-18', '2023-05-02', '2023-05-01 11:10:15', 'adiantado', NULL, 39, 38),
('2023-04-20', '2023-05-04', '2023-05-04 08:25:00', 'entregue', NULL, 40, 39),
('2023-04-22', '2023-05-06', '2023-05-07 17:00:45', 'atrasado', 10.00, 36, 40);

INSERT INTO reserva (usuario_id, livro_id, data_reserva, status_reserva, observacoes) VALUES
(36, 36, '2023-06-07', 'alugado', 'Com aviso de atraso'),
(11, 3, '2023-05-25', 'disponivel', 'Não retirado no prazo'),
(5, 18, '2023-06-03', 'reservado', 'Reserva prioritária - professor'),
(24, 2, '2023-06-02', 'disponivel', NULL),
(27, 28, '2023-06-05', 'alugado', 'Para aula específica'),
(14, 8, '2023-06-07', 'reservado', 'Para pesquisa acadêmica'),
(33, 33, '2023-06-13', 'reservado', 'Para evento cultural'),
(19, 16, '2023-05-29', 'disponivel', 'Reserva expirada'),
(7, 21, '2023-06-04', 'reservado', NULL),
(40, 40, '2023-06-11', 'alugado', 'Último exemplar'),
(22, 1, '2023-06-01', 'disponivel', 'Devolução antecipada'),
(29, 30, '2023-06-06', 'alugado', 'Com multa pendente'),
(16, 10, '2023-06-08', 'reservado', NULL),
(2, 14, '2023-05-28', 'alugado', 'Retirado em 30/05'),
(35, 35, '2023-06-15', 'reservado', 'Reserva em grupo'),
(26, 6, '2023-06-03', 'disponivel', 'Exemplar reservado errado'),
(9, 27, '2023-06-05', 'reservado', 'Cliente preferencial'),
(38, 38, '2023-06-09', 'alugado', 'Com material complementar'),
(13, 7, '2023-05-26', 'disponivel', 'Cancelada pelo usuário'),
(31, 31, '2023-06-11', 'reservado', 'Série completa'),
(4, 19, '2023-05-29', 'alugado', 'Entregue com atraso anterior'),
(20, 15, '2023-06-10', 'reservado', 'Renovação de reserva'),
(25, 23, '2023-06-04', 'alugado', 'Empréstimo especial'),
(30, 29, '2023-06-05', 'disponivel', 'Cliente não compareceu'),
(17, 11, '2023-05-28', 'disponivel', NULL),
(8, 25, '2023-05-31', 'alugado', NULL),
(3, 12, '2023-06-02', 'reservado', 'Aguardando retirada até 05/06'),
(28, 24, '2023-06-04', 'disponivel', 'Danificado na reserva'),
(10, 26, '2023-06-01', 'alugado', 'Material didático'),
(15, 9, '2023-05-27', 'disponivel', 'Exemplar devolvido'),
(37, 37, '2023-06-08', 'alugado', NULL),
(21, 17, '2023-06-02', 'alugado', 'Retirada com documento vencido'),
(34, 34, '2023-06-14', 'reservado', 'Cliente novo'),
(6, 22, '2023-05-30', 'alugado', 'Renovação automática'),
(1, 5, '2023-06-01', 'reservado', 'Cliente solicitou renovação'),
(39, 39, '2023-06-10', 'alugado', 'Devolução programada'),
(12, 4, '2023-06-06', 'reservado', 'Solicitado por app'),
(23, 20, '2023-06-03', 'alugado', NULL),
(18, 13, '2023-06-09', 'reservado', 'Cliente VIP'),
(32, 32, '2023-06-12', 'reservado', NULL);

SELECT status_reserva, COUNT(*) as total
FROM reserva
GROUP BY status_reserva;