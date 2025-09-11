/* NOMES: LESLEY DE OLIVEIRA - RA: 01252075
		  GUSTAVO RUCAGLIA BOZETTI SANTIAGO - RA: 01252040
          JOSUÉ ALVAREZ AVENDANO - RA: 01252002
		  RAFAEL PRAZERES CALDERON - RA: 01252126
          TIAGO DA SILVA SANTOS - RA: 01252133
          VICTOR RAFAEL LOURENÇO OLIVEIRA - RA: 01252058 
*/

-- Criação do banco de dados
create database projetoPI;

-- Seleção do banco de dados
use projetoPI;

-- Criação da tabela 'usuarios' com suas respectivas colunas e restrições
create table usuarios(
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(50) NOT NULL,
sobrenome VARCHAR(50) NOT NULL, 
email VARCHAR(70) NOT NULL UNIQUE,
dtNascimento DATE NOT NULL,
telCelular VARCHAR (13) NOT NULL UNIQUE,
senha VARCHAR(60) NOT NULL,
dtCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
empresa VARCHAR(100),
nivelUsuario CHAR(3), 
CONSTRAINT chkCargo CHECK( nivelUsuario IN('ADM', 'SUB')),
statusUsuario TINYINT,
CONSTRAINT chkStatus CHECK( statusUsuario IN(0, 1))
);

-- Inserção de registros na tabela
INSERT INTO usuarios(nome, sobrenome, email, dtNascimento, telCelular, senha, empresa, nivelUsuario, statusUsuario) VALUES
	('Josué', 'Alvarez Avendano', 'josue.avendano@rancho.maia', '2000-02-02', '11960181191', 'J0su3!12th3', 'Rancho do Maia', 'SUB', 1),
    ('Rafael', 'Prazeres Calderon', 'rafael.calderon@nagro.valley', '2007-02-23', '11948353845', 'R4f4!12ol', 'Nagro Valley', 'SUB', 0),
    ('Lesly', 'Oliveira', 'lesly.oliveira@bee.tec', '2004-06-21', '11961692152', 'K0l3s_3r', 'BeeTec', 'SUB', 0),
    ('Cláudio', 'Frizzarini', 'claudio.frizzarini@pedro.colmeia', '1968-05-20', '11932841827', 'fr1zz0l_', 'Fazenda Pedro da Colmeia', 'SUB', 1),
    ('Victor', 'Oliveira', 'victor.oliveira@rancho.maia', '2004-11-20', '11984739532', 'V!ctor_23', 'Rancho do Maia', 'ADM', 1),
    ('Thais', 'Miranda', 'thais.miranda@nagro.valley', '1999-02-28', '62998570998', 'b1n4r1_t4bl3', 'Nagro Valley', 'ADM', 1),
    ('Guilherme', 'Lima', 'guilherme.lima@bee.tech', '1978-12-04', '62903843945', '#gu1_Lim4', 'BeeTec', 'ADM', 1),
    ('Pedro', 'Cardoso', 'pedro.cardoso@pedro.colmeia', '1971-04-07', '86978420913', 'pedroFarm_$', 'Fazenda Pedro da Colmeia', 'ADM', 1);

-- Seleção de todos os registros contidos na tabela
SELECT * FROM usuarios;

-- Seleção do nome completo dos usuários (nome e sobrenome), com apelido de 'Nome Completo'
SELECT CONCAT(nome, ' ', sobrenome) AS 'Nome Completo' FROM usuarios;

-- Exibição dos nomes e emails com alias, além da identificação da empresa como 'Parceiras' se o e-mail contiver '@'
SELECT nome AS 'Nome do Usuário', email AS 'Email Corporativo', 
CASE 
WHEN email LIKE '%@%' THEN 'Parceiras' END AS 'Empresas' 
FROM usuarios;

-- Alteração no tamanho da coluna 'email' para 80 caractéres totais
ALTER TABLE usuarios MODIFY COLUMN email VARCHAR(80);

-- Exibição da estrutura dentro da tabela
DESCRIBE usuarios;

-- Atualização do nome do usuário com ID igual a 1
UPDATE usuarios SET nome = 'Matheus' WHERE idUsuario = 1;

-- Seleção apenas da coluna 'nome', com alias 'Nomes'
SELECT nome as Nomes FROM usuarios;

-- Exclusão da tabela
DROP TABLE usuarios;
/* ------------------------------------------------------------------------------------------------------- */

-- Criação da tabela 'empresa' armazenando informações de empresas parceiras
CREATE TABLE empresa(
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
responsavel VARCHAR(40) NOT NULL,
nomeEmpresa VARCHAR(150) NOT NULL,
logradouro VARCHAR (90) NOT NULL,
numLogradouro VARCHAR(10) NOT NULL,
cidade VARCHAR(80) NOT NULL,
UF CHAR(2) NOT NULL,
cep VARCHAR (15)  NOT NULL,
cnpj VARCHAR (14) NOT NULL UNIQUE,
telFixo VARCHAR(10) NOT NULL UNIQUE
);

-- Alteração do tipo da coluna CNPJ, aumentada para char(18)
ALTER TABLE empresa MODIFY COLUMN cnpj CHAR(18);

-- Inserção de registros na tabela
INSERT INTO empresa (responsavel, nomeEmpresa, logradouro, numLogradouro, cidade, UF, cep, cnpj, telFixo) VALUES
('Victor', 'Rancho do Maia', 'Rua da Imprensa', '48', 'Campo Grande', 'SP', '06436440', '22.245.445/0001-45', '1123750853'),
('Thais', 'Nagro Valley', 'Rua Alexandre Arckipenco', '35', 'Aparecida de Goiânia', 'GO', '03546550', '23.542.882/0001-52', '6274859048'),
('Guilherme', 'BeeTec', 'Rua Andorinha', '425', 'Pirinópolis', 'GO', '04255624', '81.523.238/0001-01', '6274890985'),
('Pedro', 'Fazenda Pedro da Colmeia', 'Rua Arlindo Nogueira', '140', 'Teresina', 'PI', '64000290', '64.705.559/0001-08', '8674830941');

/* ------------------------------------------------------------------------------------------------------- */

-- Criação da tabela 'contato' armazenando mensagens e dados de contato de interessados
CREATE TABLE contato(
idContato INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR (50) NOT NULL,
sobrenome VARCHAR (50) NOT NULL,
email VARCHAR (70) NOT NULL,
telFixo CHAR (12),
telCelular CHAR (13) NOT NULL,
empresa VARCHAR (100) NOT NULL,
cnpj CHAR (18) NOT NULL,
cargo VARCHAR(40) NOT NULL,
comentario VARCHAR(500) NOT NULL
);

-- Inserção de registros na tabela
INSERT INTO contato (nome, sobrenome, email, telCelular, empresa, cnpj, cargo, comentario) VALUES
('Victor', 'Oliveira', 'victor.oliveira@rancho.maia', '11984739532', 'Rancho do Maia', '22.245.445/0001-45' ,'ADM', 
'Sou produtor de médio porte e percebo que, em dias de calor intenso, minhas colmeias sofrem bastante. 
Gostaria de entender se o seu sistema poderia me ajudar a monitorar melhor essas variações e evitar perdas de abelhas.'),

('Thais', 'Miranda', 'thais.miranda@nagro.valley', '62998570998', 'Nagro Valley', '23.542.882/0001-52' ,'ADM', 
'Tenho várias colmeias distribuídas em diferentes apiários e a distância dificulta o acompanhamento constante. 
Vi que seu sistema pode registrar os dados remotamente, e isso me interessou muito.'),

('Guilherme', 'Lima', 'guilherme.lima@bee.tech', '62903843945', 'BeeTec', '81.523.238/0001-01', 'ADM', 
'Nos últimos anos perdi parte da produção por conta de problemas relacionados à temperatura dentro da colmeia. 
Se o seu sistema realmente ajudar a acompanhar isso em tempo real, pode ser uma ótima ferramenta para o meu trabalho.'),

('Pedro', 'Cardoso', 'pedro.cardoso@pedro.colmeia', '86978420913', 'Fazenda Pedro da Colmeia', '64.705.559/0001-08', 'ADM', 
'Aqui na minha propiedade alugamos colmeias para polinização de lavouras vizinhas. 
Saber que existe um sistema que pode monitorar a saúde térmica das colmeias me deixa animado, 
pois garante mais segurança na hora de disponibilizar as abelhas.');

-- Exibição de todos os contatos registrados
SELECT * FROM contato;

-- Exibição específica para o contato com idContato igual a 4, exibindo nome completo, e-mail e comentário, com apelidos semânticos no campos
SELECT CONCAT(nome, sobrenome) AS Nome, email AS 'Email do Usuário', comentario AS 'Comentário' FROM contato WHERE idContato = 4; 

/* ------------------------------------------------------------------------------------------------------- */

-- Criação da tabela 'registroSensor', armazenando registros de temperatura capturados por sensores
CREATE TABLE registroSensor(
idRegistroSensor INT PRIMARY KEY AUTO_INCREMENT,
sensor VARCHAR(14),
qtdTemperatura DECIMAL(4, 2),
dtTemperatura DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Inserção de registros de temperatura para os sensores em determinado horário
INSERT INTO registroSensor (sensor, qtdTemperatura) VALUES
('Sensor_001', 34.43),
('Sensor_002', 35.99),
('Sensor_003', 35.44),
('Sensor_004', 37.25);

-- Inserção de registros de temperatura para os sensores em outro determinado horário
INSERT INTO registroSensor (sensor, qtdTemperatura) VALUES
('Sensor_001', 34.23),
('Sensor_002', 35.29),
('Sensor_003', 35.74),
('Sensor_004', 34.25);

-- Exibição de todos os registros do sensor 'Sensor_001'
SELECT * FROM registroSensor
WHERE sensor = 'Sensor_001';

/* ------------------------------------------------------------------------------------------------------- */

-- Criação da tabela 'sensores', armazenando informações sobre sensores utilizados pelos clientes
CREATE TABLE sensores(
idSensor INT PRIMARY KEY AUTO_INCREMENT,
nomeSensor VARCHAR(10),
cliente VARCHAR(50)
);

-- Inserção de dados na tabela
INSERT INTO sensores (nomeSensor, cliente) VALUES
('Sensor_001', 'Nagr'),
('Sensor_002', 'Rancho do Maia'),
('Sensor_003', 'BeeTec'),
('Sensor_004', 'Fazendo Pedro da Colmeia');

-- Seleção de todos os dados dentro da tabela
SELECT * FROM sensores;

/* ------------------------------------------------------------------------------------------------------- */


-- Criação da tabela 'producaoTotal' com campos para registro de produção de mel
CREATE TABLE producaoTotal(
idProducao INT PRIMARY KEY AUTO_INCREMENT,
melKg DECIMAL(7, 2) NOT NULL,
qtdColmeia INT NOT NULL,
temperaturaMedia DECIMAL(4, 2) NOT NULL,
valorMel DECIMAL(7, 2),
dtCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
empresa VARCHAR(100)
)AUTO_INCREMENT = 1000;

-- Inserção de registros na tabela
INSERT INTO producaoTotal (melKg, qtdColmeia, temperaturaMedia, valorMel) VALUES
(12502.87, 87, 34.87, 3600.00),
(09875.09, 71, 34.99, 2850.00),
(15029.11, 94, 36.43, 6700.85),
(14500.94, 58, 35.76, 1400.90);

-- Seleção de todos os registros da tabela
SELECT * FROM producaoTotal;

-- Exibição da quantidade de colmeias e da temperatura, caso a temperatura seja maior que 36°C
SELECT qtdColmeia AS 'Quantidade de Colmeias', 
CASE WHEN temperaturaMedia > 36 
THEN CONCAT('Alta Temperatura', ' - ', temperaturaMedia, '°C') 
END AS 'Temperatura' 
FROM producaoTotal;

-- Exibição da quantidade de colmeias, mel produzido em KG e valor do mel, com apelidos semânticos
SELECT qtdColmeia AS 'Quantidade de Colmeias', melKg AS 'Mel Por Quilo', valorMel AS 'Preço do Mel' FROM  producaoTotal;

