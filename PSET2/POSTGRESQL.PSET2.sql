-- Arquivo SQL para o PostgreSQL.

-- Questão 1

SELECT
 AVG(f.salario) AS "Média salarial"
, d.nome_departamento AS "Nome do departamento" 
FROM elmasri.departamento d 
JOIN elmasri.funcionario f 
ON (d.numero_departamento = f.numero_departamento) 
GROUP BY d.nome_departamento
ORDER BY AVG(f.salario) DESC;


-- Questão 2

SELECT
 AVG(f.salario) AS "Média salarial"
, CASE f.sexo
    WHEN 'M' THEN 'Homens'
    WHEN 'F' THEN 'Mulheres'
  END AS "Sexo"
FROM elmasri.funcionario f
GROUP BY f.sexo;

-- Questão 3

SELECT
 d.nome_departamento AS "Nome do departamento"
, CONCAT(f.primeiro_nome,' ', f.nome_meio,' ',f.ultimo_nome) AS "Nome completo do funcionário" 
, data_nascimento AS "Data de nascimento"
, date_part('year', age('2022-01-01', data_nascimento)) AS "Idade" 
, f.salario AS "Salário"
FROM elmasri.departamento d 
JOIN elmasri.funcionario f 
ON d.numero_departamento = f.numero_departamento
ORDER BY d.nome_departamento, date_part('year', age('2022-01-01', data_nascimento)) DESC;

-- Questão 4 

SELECT
 CONCAT(f.primeiro_nome,' ', f.nome_meio,' ',f.ultimo_nome) AS "Nome completo do funcionário" 
, date_part('year', age('2022-01-01', data_nascimento)) AS "Idade"
, f.salario AS "Salário atual"
, CASE
    WHEN salario < 35000 THEN salario * 1.20
    WHEN salario > 34999 THEN salario * 1.15
  END AS "Novo salário"
FROM elmasri.funcionario f
ORDER BY "Novo salário" DESC;

-- Questão 5

SELECT
 d.nome_departamento AS "Nome do departamento"
, CASE
    WHEN (d.cpf_gerente = f.cpf) 
    THEN CONCAT(f.primeiro_nome,' ', f.nome_meio,' ', f.ultimo_nome) 
  END AS "Nome do gerente"
, CASE 
    WHEN d.cpf_gerente != f.cpf 
    THEN CONCAT(f.primeiro_nome,' ', f.nome_meio,' ', f.ultimo_nome)
  END AS "Nome completo do funcionário"
, CASE 
    WHEN (d.cpf_gerente != f.cpf) 
    THEN f.salario
  END AS "Salário do funcionário"
FROM elmasri.departamento d
INNER JOIN elmasri.funcionario f 
ON (d.numero_departamento = f.numero_departamento)
ORDER BY d.nome_departamento ASC, "Salário do funcionário" DESC;

-- Questão 6 

SELECT 
 CONCAT(f.primeiro_nome,' ', f.nome_meio,' ', f.ultimo_nome) AS "Nome completo do funcionário"
, dp.nome_departamento AS "Nome do departamento"
, d.nome_dependente AS "Nome do dependente"
, date_part('year', age('2022-01-01', d.data_nascimento)) AS "Idade do dependente"
, CASE d.sexo
    WHEN 'M' THEN 'Masculino'
    WHEN 'F' THEN 'Feminino'
  END AS "Sexo do dependente"
FROM elmasri.funcionario f
INNER JOIN elmasri.dependente d 
ON (d.cpf_funcionario = f.cpf)
INNER JOIN elmasri.departamento dp 
ON (dp.numero_departamento = f.numero_departamento)
ORDER BY dp.nome_departamento;

-- Questão 7

SELECT
 CONCAT(f.primeiro_nome,' ',f.nome_meio,' ',f.ultimo_nome) AS "Nome completo do funcionário"
, dt.nome_departamento AS "Nome do departamento"
, CASE 
    WHEN d.nome_dependente IS NULL 
    THEN f.salario
  END AS "Salário"
FROM elmasri.funcionario f
JOIN elmasri.departamento dt
ON (f.numero_departamento = dt.numero_departamento)
LEFT JOIN elmasri.dependente d 
ON (f.cpf = d.cpf_funcionario)
WHERE d.nome_dependente IS NULL;

-- Questão 8

SELECT
 t.horas AS "Horas trabalhadas"
, CONCAT(f.primeiro_nome,' ',f.nome_meio,' ',f.ultimo_nome) AS "Nome completo do funcionário" 
, p.nome_projeto AS "Nome do projeto"
, d.nome_departamento AS "Nome do departamento"
FROM elmasri.trabalha_em t
JOIN elmasri.projeto p 
ON t.numero_projeto = p.numero_projeto
JOIN elmasri.departamento d
ON p.numero_departamento = d.numero_departamento
JOIN elmasri.funcionario f
ON f.cpf = t.cpf_funcionario
ORDER BY d.nome_departamento, p.nome_projeto, CONCAT(f.primeiro_nome,' ',f.nome_meio,' ',f.ultimo_nome);

-- Questão 9

SELECT 
 SUM(t.horas) AS "Soma de horas Trabalhadas"
, p.nome_projeto AS "Nome do projeto"
, d.nome_departamento AS "Nome do departamento"
FROM elmasri.trabalha_em t
JOIN elmasri.projeto p
ON (p.numero_projeto = t.numero_projeto)
JOIN elmasri.departamento d
ON (d.numero_departamento = p.numero_departamento)
WHERE t.numero_projeto = t.numero_projeto 
GROUP BY t.numero_projeto, p.nome_projeto, d.nome_departamento
ORDER BY d.nome_departamento;

-- Questão 10

SELECT
 AVG(f.salario) AS "Média Salaraial"
, d.nome_departamento AS "Nome do Departamento"
FROM elmasri.funcionario f
JOIN elmasri.departamento d 
ON (f.numero_departamento = d.numero_departamento)
GROUP BY d.nome_departamento
ORDER BY AVG(f.salario) DESC;

-- Questão 11

SELECT
 CONCAT(f.primeiro_nome,' ',f.nome_meio,' ',f.ultimo_nome) AS "Nome completo do funcionário"
, p.nome_projeto AS "Nome do Projeto"
, t.horas AS "Horas Trabalhadas"
, CASE
  WHEN t.horas > 0
  THEN t.horas*50
  END AS "Valor pago"
FROM elmasri.trabalha_em t 
JOIN elmasri.funcionario f
ON (f.cpf = t.cpf_funcionario)
JOIN elmasri.projeto p
ON (p.numero_projeto = t.numero_projeto)
ORDER BY CONCAT(f.primeiro_nome,' ',f.nome_meio,' ',f.ultimo_nome), p.nome_projeto, t.horas ASC;

-- Questão 12

SELECT
 d.nome_departamento AS "Nome do Departamento"
, p.nome_projeto AS "Nome do Projeto"
, CONCAT(f.primeiro_nome,' ',f.nome_meio,' ',f.ultimo_nome) AS "Nome completo do funcionário"
, t.horas AS "Horas Trabalhadas"
FROM elmasri.departamento d
JOIN elmasri.projeto p
ON (p.numero_departamento = d.numero_departamento)
JOIN elmasri.funcionario f
ON (f.numero_departamento = d.numero_departamento)
JOIN elmasri.trabalha_em t
ON (t.numero_projeto = p.numero_projeto)
WHERE t.horas IS NULL;

-- Questão 13

SELECT
 CONCAT(f.primeiro_nome,' ',f.nome_meio,' ',f.ultimo_nome) AS "Nome completo"
, CASE f.sexo
   WHEN 'M' THEN 'Masculino'
   WHEN 'F' THEN 'Feminino'
  END AS "Sexo"
, date_part('year', age('2022-01-01', data_nascimento)) AS "Idade"
FROM elmasri.funcionario f 
UNION
SELECT
 d.nome_dependente AS "Nome Completo"
, CASE d.sexo
   WHEN 'M' THEN 'Masculino'
   WHEN 'F' THEN 'Feminino'
  END AS "Sexo"
, date_part('year', age('2022-01-01', data_nascimento)) AS "Idade"
FROM elmasri.dependente d
ORDER BY "Idade" DESC;

-- Questão 14

SELECT
 d.nome_departamento AS "Nome do Departamento"
, CASE 
    WHEN f.numero_departamento = d.numero_departamento 
    THEN COUNT(f.cpf) end as "Total de Funcionários"
FROM elmasri.departamento d
JOIN elmasri.funcionario f
ON (f.numero_departamento = d.numero_departamento)
GROUP BY d.nome_departamento, d.numero_departamento, f.numero_departamento
ORDER BY "Total de Funcionários" DESC;

-- Questão 15 ****

SELECT
 CONCAT(f.primeiro_nome,' ',f.nome_meio,' ',f.ultimo_nome) AS "Nome completo"
, d.nome_departamento AS "Nome do departamento"
, p.nome_projeto AS "Nome do projeto"
FROM elmasri.trabalha_em t
JOIN elmasri.funcionario f
ON (t.cpf_funcionario = f.cpf)
JOIN elmasri.projeto p
ON (p.numero_projeto = t.numero_projeto)
JOIN elmasri.departamento d
ON (d.numero_departamento = p.numero_departamento)
WHERE p.numero_departamento = f.numero_departamento
ORDER BY f.primeiro_nome;


-- Fim do arquivo SQL para o PostgreSQL.


