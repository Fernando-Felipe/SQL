CREATE DATABASE livraria
GO
USE livraria


CREATE TABLE livro(
codigo		INT				NOT NULL IDENTITY(100001,100),
nome		VARCHAR(200)	NOT NULL,
lingua		VARCHAR(10)		NOT NULL DEFAULT('PT-BR'),
ano			INT				NOT NULL CHECK( ano >= 1990)
PRIMARY KEY(codigo)
)
GO
CREATE TABLE autor(
idAutor		INT				NOT NULL IDENTITY(2351,1),
nome		VARCHAR(100)	NOT NULL UNIQUE,
dataNasc	DATE			NOT NULL,
paisNasc	VARCHAR(50)		NOT NULL CHECK(UPPER(paisNasc) = 'BRASIL' OR UPPER(paisNasc) = 'INGLATERRA' OR UPPER(paisNasc) = 'ALEMANHA'),
biografia	VARCHAR(255)	NOT NULL
PRIMARY KEY(idAutor)
)
GO
CREATE TABLE editora(
idEditora	INT				NOT NULL IDENTITY(491,16),
nome		VARCHAR(70)		NOT NULL UNIQUE,
telefone	VARCHAR(10)		NOT NULL CHECK(LEN(telefone) = 10),
logradouro	VARCHAR(200)	NOT NULL,
numero		INT				NOT NULL CHECK(numero > 0),
cep			char(8)			NOT NULL CHECK(LEN(cep) = 8),
complemento VARCHAR(255)	NOT NULL
PRIMARY KEY(idEditora)
)
GO
CREATE TABLE edicao(
isbn		CHAR(13)		NOT NULL CHECK(LEN(isbn) = 13),
preco		DECIMAL(4,2)	NOT NULL CHECK(preco >= 0),
ano			INT				NOT NULL CHECK(ano >= 1993),
pag			INT				NOT NULL CHECK(pag >= 15),
qtd			INT				NOT NULL
PRIMARY KEY(isbn)
)
GO
CREATE TABLE livroAutor(
livroCodigo		INT		NOT NULL,
autorID			INT		NOT NULL
PRIMARY KEY(livroCodigo, autorID)
FOREIGN KEY(livroCodigo) REFERENCES livro(codigo),
FOREIGN KEY(autorID)	 REFERENCES autor(idAutor)
)
GO
CREATE TABLE editoraEdicaoLivro(
editoraID	INT			NOT NULL,
edicaoISBN	CHAR(13)	NOT NULL,
livroCodigo INT			NOT NULL
PRIMARY KEY(editoraID, edicaoISBN, livroCodigo)
FOREIGN KEY(editoraID) REFERENCES editora(idEditora),
FOREIGN KEY(edicaoISBN) REFERENCES edicao(isbn),
FOREIGN KEY(livroCodigo) REFERENCES livro(codigo)
)

EXEC sp_help editoraEdicaoLivro
EXEC sp_help LivroAutor
EXEC sp_help livro
EXEC sp_help autor
EXEC sp_help edicao
EXEC sp_help editora

Select * FROM livro
Select * FROM autor
Select * FROM edicao
Select * FROM editora
Select * FROM livroAutor
Select * FROM editoraEdicaoLivro



