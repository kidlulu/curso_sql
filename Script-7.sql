SELECT
 A01ra 
FROM 
 pdad.dom2021;

SELECT
 A01ra,
 A01npessoas
FROM 
 pdad.dom2021

SELECT
 *
FROM 
 pdad.dom2021

--Forma 1
SELECT
 B10,
 B11,
 B12,
 B10*B11/B12 as exemplo1,
 B10/B11*B12 as exemplo2,
 B10+B11-B12 as exemplo3,
 B10-B11+B12 as exemplo4
FROM 
 pdad.dom2021;

--Forma 2
SELECT
 B10 AS "Total de cômodos",
 B11 AS " Qtd. de cômodos servindo permanentemente de dormitórios",
 B12 AS " Qtd. de banheiros e/ou sanitários",
 B10*B11/B12 AS "Primeiro exemplo",
 B10/B11*B12 AS "Segundo exemplo",
 B10+B11-B12 AS "Terceiro exemplo",
 B10-B11+B12 AS "Quarto exemplo"
FROM 
 pdad.dom2021;

--Forma 1 (Sem ordenação)
SELECT
 A01ra,
 B10,
 B11,
 B12
FROM 
 pdad.dom2021;

--Forma 2 (Ordem ascendente)
SELECT
 A01ra,
 B10,
 B11,
 B12
FROM 
 pdad.dom2021
ORDER BY 
 A01ra;

--Forma 3 (Ordem descendente)
SELECT
 A01ra,
 B10,
 B11,
 B12
FROM 
 pdad.dom2021
ORDER BY 
 A01ra DESC;

SELECT
 DISTINCT A01ra, A01setor
FROM 
 pdad.dom2021
order by 
 A01ra,
 A01setor;

SELECT
 CASE WHEN E06 = 1 THEN 1
      WHEN E06 = 3 THEN 1
      WHEN E06 = 5 THEN 1
      WHEN E06 = 2 THEN 2
      WHEN E06 = 4 THEN 2
      ELSE 3
 END AS negro_naonegro
FROM pdad.mor2021;

SELECT
 CASE WHEN E06 IN (1,3,5) THEN 1
      WHEN E06 IN (2,4) THEN 2
      ELSE 3
 END AS negro_naonegro
FROM pdad.mor2021;

SELECT
 *
FROM
 pdad.mor2021
WHERE 
 idade > 18;

--Selecionar pessoas com idade igual a 18 anos;
SELECT * 
FROM pdad.mor2021
WHERE idade = 18;

--Selecionar pessoas com idade diferente de 18 anos;
SELECT * 
FROM pdad.mor2021
WHERE idade <> 18;

--Selecionar pessoas com idade maior ou igual a 18 anos;
SELECT * 
FROM pdad.mor2021
WHERE idade >= 18;

--Selecionar domicílios com renda domiciliar per-capita menor ou igual a R$100,00;
SELECT * 
FROM pdad.dom2021
WHERE renda_domiciliar_pc_r <= 100;

--Selecionar pessoas com idade entre 18 e 24 anos;
SELECT * 
FROM pdad.mor2021
WHERE idade BETWEEN 18 AND 24;

--Selecionar pessoas que não tenham idade entre 18 e 24 anos;
SELECT * 
FROM pdad.mor2021
WHERE idade NOT BETWEEN 18 AND 24;

--Selecionar domicílios que tenham renda domiciliar per-capita real vazia;
SELECT * 
FROM pdad.dom2021
WHERE renda_domiciliar_pc_r is null;

--Selecionar pessoas com idade menor que 18 anos e com algum rendimento real entre R$100,00 e R$500,00;
SELECT * 
FROM pdad.mor2021
WHERE idade < 18
AND renda_ind_r BETWEEN 100 AND 500;

--Selecionar pessoas com idade menor que 18 anos ou maior que 50 anos;
SELECT * 
FROM pdad.mor2021
WHERE idade < 18
OR idade > 50;

--Selecionar pessoas com as seguintes idades: 5, 50, 59 e 100;
SELECT * 
FROM pdad.mor2021
WHERE idade in (5,50,59,100);

--Exemplo 1
SELECT 
 A01nficha,
 B10,
 B11,
 B12
FROM 
 pdad.dom2021
WHERE 
 B10 = 5 OR B11 = 3 AND B12 = 2;
ORDER BY 
 A01nficha;

--Exemplo 2
SELECT
 A01nficha, 
 B10,
 B11,
 B12
FROM 
 pdad.dom2021
WHERE 
 (B10 = 5 OR B11 = 3) AND B12 = 2
ORDER BY 
 A01nficha;

SELECT 
 AVG(renda_ind_r) AS media,
 SUM(renda_ind_r) AS soma,
 COUNT(*) AS contagem,
 SUM(CASE WHEN renda_ind_r IS NULL THEN 1 ELSE 0 END) AS contagem_nulo
FROM pdad.mor2021;

SELECT
 E06,
 AVG(renda_ind_r) AS media,
 SUM(renda_ind_r) AS soma,
 COUNT(*) AS contagem,
 SUM(CASE WHEN renda_ind_r IS NULL THEN 1 ELSE 0 END) AS contagem_nulo
FROM pdad.mor2021
GROUP BY E06;

SELECT
 CASE WHEN E06 IN (1,3,5) THEN 1
      WHEN E06 IN (2,4) THEN 2
      ELSE 3
 END AS negro_naonegro,
 AVG(renda_ind_r) AS media,
 SUM(renda_ind_r) AS soma,
 COUNT(*) AS contagem,
 SUM(CASE WHEN renda_ind_r IS NULL THEN 1 ELSE 0 END) AS contagem_nulo
FROM pdad.mor2021
GROUP BY 
 CASE WHEN E06 IN (1,3,5) THEN 1
      WHEN E06 IN (2,4) THEN 2
      ELSE 3
 END;

--Exemplo 01
SELECT 
 A01nficha,
 SUM(renda_ind_r) "Soma do rendimento individual"
FROM pdad.mor2021 
WHERE renda_ind_r > 10000
GROUP BY A01nficha
ORDER BY SUM(renda_ind_r) DESC;

--Exemplo 02
SELECT 
 A01nficha,
 SUM(renda_ind_r) "Soma do rendimento individual"
FROM pdad.mor2021 
GROUP BY A01nficha
HAVING SUM(renda_ind_r) > 10000
ORDER BY SUM(renda_ind_r) DESC;

SELECT
 m.E04,
 SUM(d.PESO_DOM) AS qtd_resp_dom
FROM pdad.dom2021 AS d 
JOIN pdad.mor2021 AS m 
ON d.A01nficha = m.A01nficha 
WHERE m.E05 = 1
GROUP BY m.E04;

SELECT
 m.E04,
 SUM(d.PESO_DOM) AS qtd_resp_dom
FROM
 pdad.dom2021 AS d
LEFT JOIN
 pdad.mor2021 AS m 
ON
 d.A01nficha = m.A01nficha 
WHERE
 m.E05 = 1
GROUP BY 
 m.E04;

SELECT
 m.E04,
 SUM(d.PESO_DOM) AS qtd_resp_dom
FROM
 pdad.dom2021 AS d 
RIGHT JOIN
 pdad.mor2021 AS m 
ON
 d.A01nficha = m.A01nficha 
WHERE
 m.E05 = 1
GROUP BY 
 m.E04;

SELECT
 m.E04,
 SUM(d.PESO_DOM) AS qtd_resp_dom
FROM
 pdad.dom2021 AS d 
LEFT JOIN
 pdad.mor2021 AS m 
ON
 d.A01nficha = m.A01nficha 
WHERE
 m.E05 = 1
GROUP BY 
 m.E04;

select * from pdad.mor2021














--INNER JOIN
SELECT
 CASE WHEN d.inseg_alimentar = 1 THEN 'Segurança'
      WHEN d.inseg_alimentar = 2 THEN 'Insegurança leve'
      WHEN d.inseg_alimentar = 3 THEN 'Insegurança moderada'
      WHEN d.inseg_alimentar = 4 THEN 'Insegurança grave'
      WHEN d.inseg_alimentar = 5 THEN 'Sem classificação'
      ELSE NULL
 END AS "Escala Brasileira de Insegurança Alimentar",
 ROUND(SUM(d.PESO_DOM),0) AS 'Qtd. estimada de domicílios'
FROM pdad.dom2021 d 
JOIN pdad.mor2021 m 
ON d.A01nficha = m.A01nficha 
WHERE m.idade BETWEEN 0 and 5 
GROUP BY CASE WHEN d.inseg_alimentar = 1 THEN 'Segurança'
              WHEN d.inseg_alimentar = 2 THEN 'Insegurança leve'
              WHEN d.inseg_alimentar = 3 THEN 'Insegurança moderada'
              WHEN d.inseg_alimentar = 4 THEN 'Insegurança grave'
              WHEN d.inseg_alimentar = 5 THEN 'Sem classificação'
              ELSE NULL
         END

--LEFT JOIN
SELECT
 CASE WHEN d.inseg_alimentar = 1 THEN 'Segurança'
      WHEN d.inseg_alimentar = 2 THEN 'Insegurança leve'
      WHEN d.inseg_alimentar = 3 THEN 'Insegurança moderada'
      WHEN d.inseg_alimentar = 4 THEN 'Insegurança grave'
      WHEN d.inseg_alimentar = 5 THEN 'Sem classificação'
      ELSE NULL
 END AS "Escala Brasileira de Insegurança Alimentar",
 ROUND(SUM(d.PESO_DOM),0) AS 'Qtd. estimada de domicílios'
FROM pdad.dom2021 d 
JOIN pdad.mor2021 m 
ON d.A01nficha = m.A01nficha 
WHERE m.idade BETWEEN 0 and 5 
GROUP BY CASE WHEN d.inseg_alimentar = 1 THEN 'Segurança'
              WHEN d.inseg_alimentar = 2 THEN 'Insegurança leve'
              WHEN d.inseg_alimentar = 3 THEN 'Insegurança moderada'
              WHEN d.inseg_alimentar = 4 THEN 'Insegurança grave'
              WHEN d.inseg_alimentar = 5 THEN 'Sem classificação'
              ELSE NULL
         END

--Exemplo de UNION
SELECT
 CASE WHEN d.C10_1 BETWEEN 1 and 30 AND d.C10_2 = 0 THEN 'Possui gatos'
      WHEN d.C10_2 BETWEEN 1 and 15 AND d.C10_1 = 0 THEN 'Possui cachorros'
      ELSE NULL
 END AS 'Possui gato ou cachorro',
 ROUND(SUM(m.PESO_MOR),0) AS 'Qtd. estimada de domicílios'
FROM pdad.mor2021 m 
LEFT JOIN pdad.dom2021 d 
ON m.A01nficha = d.A01nficha 
GROUP BY CASE WHEN d.C10_1 BETWEEN 1 and 30 AND d.C10_2 = 0 THEN 'Possui gatos'
              WHEN d.C10_2 BETWEEN 1 and 15 AND d.C10_1 = 0 THEN 'Possui cachorros'
              ELSE NULL
         END
UNION
SELECT
 CASE WHEN d.C10_1 BETWEEN 1 and 30 AND d.C10_2 = 0 THEN 'Possui gatos'
      WHEN d.C10_2 BETWEEN 1 and 15 AND d.C10_1 = 0 THEN 'Possui cachorros'
      ELSE NULL
 END AS 'Possui gato ou cachorro',
 ROUND(SUM(m.PESO_MOR),0) AS 'Qtd. estimada de domicílios'
FROM pdad.mor2021 m 
LEFT JOIN pdad.dom2021 d 
ON m.A01nficha = d.A01nficha 
GROUP BY CASE WHEN d.C10_1 BETWEEN 1 and 30 AND d.C10_2 = 0 THEN 'Possui gatos'
              WHEN d.C10_2 BETWEEN 1 and 15 AND d.C10_1 = 0 THEN 'Possui cachorros'
              ELSE NULL
         END



SELECT
 CASE WHEN d.C10_1 BETWEEN 1 and 30 AND d.C10_2 = 0 THEN 'Possui gatos'
      ELSE NULL
 END AS 'Possui gato ou cachorro',
 ROUND(SUM(m.PESO_MOR),0) AS 'Qtd. estimada de domicílios'
FROM pdad.mor2021 m 
LEFT JOIN pdad.dom2021 d 
ON m.A01nficha = d.A01nficha 
GROUP BY CASE WHEN d.C10_1 BETWEEN 1 and 30 AND d.C10_2 = 0 THEN 'Possui gatos'
              ELSE NULL
         END
UNION
SELECT
 CASE WHEN d.C10_2 BETWEEN 1 and 15 AND d.C10_1 = 0 THEN 'Possui cachorros'
      ELSE NULL
 END AS 'Possui gato ou cachorro',
 ROUND(SUM(m.PESO_MOR),0) AS 'Qtd. estimada de domicílios'
FROM pdad.mor2021 m 
LEFT JOIN pdad.dom2021 d 
ON m.A01nficha = d.A01nficha 
GROUP BY CASE WHEN d.C10_2 BETWEEN 1 and 15 AND d.C10_1 = 0 THEN 'Possui cachorros'
              ELSE NULL
         END

SELECT
 CASE WHEN d.C10_1 BETWEEN 1 and 30 AND d.C10_2 = 0 THEN 'Possui gatos'
      ELSE NULL
 END AS 'Possui gato ou cachorro',
 ROUND(SUM(m.PESO_MOR),0) AS 'Qtd. estimada de domicílios'
FROM pdad.mor2021 m 
LEFT JOIN pdad.dom2021 d 
ON m.A01nficha = d.A01nficha 
GROUP BY CASE WHEN d.C10_1 BETWEEN 1 and 30 AND d.C10_2 = 0 THEN 'Possui gatos'
              ELSE NULL
         END
UNION ALL
SELECT
 CASE WHEN d.C10_2 BETWEEN 1 and 15 AND d.C10_1 = 0 THEN 'Possui cachorros'
      ELSE NULL
 END AS 'Possui gato ou cachorro',
 ROUND(SUM(m.PESO_MOR),0) AS 'Qtd. estimada de domicílios'
FROM pdad.mor2021 m 
LEFT JOIN pdad.dom2021 d 
ON m.A01nficha = d.A01nficha 
GROUP BY CASE WHEN d.C10_2 BETWEEN 1 and 15 AND d.C10_1 = 0 THEN 'Possui cachorros'
              ELSE NULL
         END