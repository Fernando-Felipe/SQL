SELECT * FROM peca

CREATE OR REPLACE PROCEDURE sp_inserir_peca (
	p_codpeca		VARCHAR(3),
	p_nomepeca		VARCHAR(20),
	p_corpeca		VARCHAR(20),
	p_pesopeca		INT,
	p_cidadepeca	VARCHAR(20)
)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO peca (codpeca, nomepeca, corpeca, pesopeca, cidadepeca)
	VALUES (p_codpeca, p_nomepeca, p_corpeca, p_pesopeca, p_cidadepeca);
END;
$$;

CALL sp_inserir_peca('P4', 'Paraduso', 'Prata', 20, 'São Paulo')