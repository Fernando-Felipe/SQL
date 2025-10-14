CREATE DATABASE Clinica
GO
USE Clinica

CREATE TABLE PACIENTE(
numBeneficiario		INT				NOT NULL,
nome				VARCHAR(100)	NOT NULL,
logradouro			VARCHAR(200)	NOT NULL,
numero				INT				NOT NULL,
cep					CHAR(8)			NOT NULL,
complemento			VARCHAR(255)	NULL,
telefone			VARCHAR(11)     NOT NULL
PRIMARY KEY (numBeneficiario)
)
GO
CREATE TABLE ESPECIALIDADE(
id				INT				NOT NULL,
especialidade	VARCHAR(100)	NOT NULL
PRIMARY KEY (id)
)
GO
CREATE TABLE MEDICO(
codigo			INT				NOT NULL,
nome			VARCHAR(100)	NOT NULL,
logradouro		VARCHAR(200)	NOT NULL,
numero			INT				NOT NULL,
cep				CHAR(8)			NOT NULL,
complemento		VARCHAR(255)	NULL,
contato			VARCHAR(11)		NOT NULL,
especialidadeID INT				NOT NULL
PRIMARY KEY (codigo),
FOREIGN KEY (especialidadeID) REFERENCES ESPECIALIDADE (id)
)
GO
CREATE TABLE CONSULTA(
pacienteNumBeneficiario		INT				NOT NULL,
medicoCodigo				INT				NOT NULL,
dataHora					DATETIME		NOT NULL,
observacao					VARCHAR(255)	NOT NULL
PRIMARY KEY (pacienteNumBeneficiario, medicoCodigo, dataHora),
FOREIGN KEY (pacienteNumBeneficiario) REFERENCES PACIENTE (numBeneficiario),
FOREIGN KEY (medicoCodigo) REFERENCES MEDICO (codigo)
)
EXEC sp_help PACIENTE
EXEC sp_help MEDICO
EXEC sp_help ESPECIALIDADE
EXEC sp_help CONSULTA

INSERT INTO PACIENTE VALUES
(99901, 'Washington Silva', 'R.Anhaia', 150, '02345000', 'Casa', '922229999'),
(99902, 'Luis Ricardo', 'R.Voluntarios da Patria', 2251, '03254010', 'Bloco B.Apto 25', '923450987'),
(99903, 'Maria Elisa', 'Av.Aguia de Haia', 1188, '0698720', 'Apto 1208', '912348765'),
(99904, 'Jose Araujo', 'R.XV de Novembro', 18, '03678000', 'Casa', '945674321'),
(99905, 'Joana Paula', 'R.7 de Abril', 97, '01214000', 'Conjunto 3 - Apto 801', '912095674')

INSERT INTO MEDICO VALUES
(100001, 'Ana Paula', 'R.7 de Setembro', 256, '03698000', 'Casa', '915689456', 1),
(100002, 'Maria Aparecida', 'Av.Brasil', 32, '02145070', 'Casa', '923235454', 1),
(100003, 'Lucas Borges', 'Av.do Estado', 3210, '05241000', 'Apto 205', '963698585', 2),
(100004, 'Gabriel Oliveira', 'Av.Dom Helder Camara', 350,'03145000', 'Apto 602', '932458745', 3)

INSERT INTO ESPECIALIDADE VALUES
(1, 'Otorrinolaringologista'),
(2, 'Urologista'),
(3, 'Geriatria'),
(4, 'Pediatria')

INSERT INTO CONSULTA VALUES
(99901, 100002, '2021-09-04 13:20', 'Infeccao de Urina'),
(99902, 100003, '2021-09-04 13:15', 'Gripe'),
(99901, 100001, '2021-09-04 12:30', 'Infeccao de Garganta')

ALTER TABLE MEDICO
ADD dia_atendimento VARCHAR(8) NULL

UPDATE MEDICO
SET dia_atendimento = '2 feira'
WHERE codigo = 100001

UPDATE MEDICO
SET dia_atendimento = '4 feira'
WHERE codigo = 100002

UPDATE MEDICO
SET dia_atendimento = '2 feira'
WHERE codigo = 100003

UPDATE MEDICO
SET dia_atendimento = '5 feira'
WHERE codigo = 100004

DELETE ESPECIALIDADE
WHERE id = 4

EXEC sp_rename 'dbo.medico.dia_atendimento','dia_semana_atendimento','COLUMN'

UPDATE MEDICO
SET logradouro = 'AV.Bras Leme'
WHERE codigo = 100003

UPDATE MEDICO
SET numero = 876
WHERE codigo = 100003

UPDATE MEDICO
SET cep = '02122000'
WHERE codigo = 100003

UPDATE MEDICO
SET complemento = 'Apto 504'
WHERE codigo = 100003

ALTER TABLE CONSULTA
ALTER COLUMN observacao VARCHAR(200)


SELECT * FROM PACIENTE
SELECT * FROM MEDICO
SELECT * FROM ESPECIALIDADE
SELECT * FROM CONSULTA