--1
SELECT COUNT(CodFornec) AS TotalFornecedores
FROM fornec;

--2
SELECT COUNT(DISTINCT CidadeFornec) AS CidadesFornec
FROM fornec;

--3
SELECT COUNT(CodFornec) AS FornecComCidade
FROM fornec
WHERE CidadeFornec IS NOT NULL;

--4
SELECT MAX(QtdeEmbarc) AS MaiorEmbarc
FROM embarq;

--5
SELECT f.NomeFornec, COUNT(e.QtdeEmbarc)
FROM fornec f
INNER JOIN embarq e ON e.CodFornec = f.CodFornec
GROUP BY f.NomeFornec;

--6
SELECT f.NomeFornec, COUNT(e.QtdeEmbarc)
FROM fornec f
INNER JOIN embarq e ON e.CodFornec = f.CodFornec
WHERE e.QtdeEmbarc > 300
GROUP BY f.NomeFornec;

--7
SELECT f.NomeFornec, SUM(e.QtdeEmbarc), p.CorPeca
FROM fornec f
INNER JOIN embarq e ON e.CodFornec = f.CodFornec
INNER JOIN peca p ON p.CodPeca = e.CodPeca
WHERE p.CorPeca = 'Cinza'
GROUP BY f.NomeFornec, p.CorPeca;

--8
SELECT f.NomeFornec, SUM(e.QtdeEmbarc)
FROM fornec f
INNER JOIN embarq e ON e.CodFornec = f.CodFornec
GROUP BY f.NomeFornec
ORDER BY SUM(e.QtdeEmbarc) DESC;

--9
SELECT f.CodFornec,
			COUNT(e.CodPeca),
			SUM(e.QtdeEmbarc)
FROM fornec f
INNER JOIN embarq e ON e.CodFornec = f.CodFornec
INNER JOIN peca p ON p.CodPeca = e.CodPeca
WHERE p.CorPeca = 'Cinza'
GROUP BY f.CodFornec
HAVING SUM(e.QtdeEmbarc) > 300;








