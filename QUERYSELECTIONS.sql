SELECT e.nome AS nomeLivro, e.valor AS valorLivro, 
ed. nome AS nomeEditora, a.nome AS nomeAutor
FROM estoque e, editora ed, autor a
WHERE e.codEditora = ed.codigo
AND e.codAutor = a.codigo

SELECT c.codigo AS codigoCompra ,e.nome AS nomeLivro, c.qtdComprada, c.valor AS valorCompra
FROM estoque e, compra c
WHERE c.codEstoque = e.codigo
AND c.codigo = 15051

SELECT e.nome AS nomeLivro,
CASE WHEN (LEN(ed.site) > 10)
	THEN SUBSTRING(ed.site,5,LEN(ed.site))
	ELSE ed.site
	END AS site
FROM estoque e, editora ed
WHERE e.codEditora = ed.codigo
AND ed.nome = 'Makron Books'

SELECT e.nome AS nomeLivro, au.biografia
FROM estoque e, autor au
WHERE e.codAutor = au.codigo
AND au.nome = 'David Halliday'

SELECT c.codigo, c.qtdComprada, e.nome AS nomeLivro
FROM compra c, estoque e
WHERE c.codEstoque = e.codigo
AND e.nome = 'Sistemas Operacionais Modernos'

SELECT e.nome AS nomeLivro, c.qtdComprada
FROM estoque e LEFT OUTER JOIN compra c
ON c.codEstoque = e.codigo
WHERE c.qtdComprada IS NULL

SELECT e.nome AS nomeLivro
FROM compra c LEFT OUTER JOIN estoque e
ON e.codigo = c.codEstoque
WHERE e.codigo IS NULL

SELECT ed.nome AS nomeEditora,
CASE WHEN (LEN(ed.site) > 10)
	THEN SUBSTRING(ed.site,5,LEN(ed.site))
	ELSE ed.site
	END AS site
FROM editora ed LEFT OUTER JOIN estoque e
ON e.codEditora = ed.codigo
WHERE e.codEditora IS NULL

SELECT au.nome AS nomeAutor,
	REPLACE(au.biografia, 'Doutorado', 'Ph.D') AS biografia
FROM autor au LEFT OUTER JOIN estoque e
ON e.codAutor = au.codigo
WHERE e.codAutor IS NULL


SELECT au.nome AS nomeAutor, MAX(e.valor) AS valorLivro
FROM autor au, estoque e
WHERE e.codAutor = au.codigo
GROUP BY au.nome 
ORDER BY MAX(e.valor) DESC


SELECT c.codigo AS codigoCompra, COUNT(c.qtdComprada) AS qtdTotal, SUM(c.valor) AS ValorTotal
FROM compra c
GROUP BY c.codigo
ORDER BY c.codigo ASC

SELECT ed.nome AS nomeEditora,
AVG(e.valor) AS mediaLivros
FROM estoque e, editora ed
WHERE e.codEditora = ed.codigo
GROUP BY ed.nome
ORDER BY AVG(e.valor) ASC

SELECT e.nome AS nomeLivro, e.quantidade AS qtdLivro, ed.nome as nomeEditora,
CASE WHEN (e.quantidade < 5)
	THEN 'Produto em Ponto de Pedido'
WHEN (e.quantidade >= 5 AND e.quantidade <= 10)
	THEN 'Produto Acabando'
WHEN (e.quantidade > 10)
	THEN 'Estoque Suficiente'
END AS Status,
CASE WHEN (LEN(ed.site) > 10)
	THEN SUBSTRING(ed.site,5,LEN(ed.site))
	ELSE ed.site
	END AS site
FROM estoque e, editora ed
WHERE e.codEditora = ed.codigo
ORDER BY e.quantidade ASC

SELECT e.codigo AS codigoLivro, e.nome AS nomeLivro, au.nome AS nomeAutor, 
CASE WHEN (ed.site IS NULL)
	THEN ed.nome
	ELSE ed.nome +' '+ ed.site
	END AS infoEditora
FROM estoque e, autor au, editora ed
WHERE e.codAutor = au.codigo
AND ed.codigo = e.codEditora