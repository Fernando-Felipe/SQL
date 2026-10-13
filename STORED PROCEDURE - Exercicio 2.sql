SELECT * FROM peca;
ALTER TABLE peca ALTER COLUMN codpeca TYPE VARCHAR(6);
SELECT COUNT(*) FROM peca;

CREATE OR REPLACE PROCEDURE sp_inserir_peca_500()
LANGUAGE plpgsql
AS $$
DECLARE
    v_cores    VARCHAR(20)[] := ARRAY['Cinza','Preto','Verde','Azul','Vermelho'];
    v_cidades  VARCHAR(20)[] := ARRAY['Rio','São Paulo','Poa','Curitiba','Salvador'];
    i          INT;
BEGIN
	FOR i IN  10..5009 LOOP
		INSERT INTO peca (codpeca, nomepeca, corpeca, pesopeca, cidadepeca)
		VALUES (
		'P' || i,
		'Peca' || i,
		v_cores[(floor(random() * array_length(v_cores, 1)) + 1)::INT],
		(floor(random() * 100) + 1)::INT,
		v_cidades[(floor(random() * array_length(v_cidades, 1)) + 1)::INT]
		);
	END LOOP;
END;
$$;

CALL sp_inserir_peca_500();