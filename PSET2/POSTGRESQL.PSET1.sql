-- Arquivo SQL para o PostgreSQL.

-- Deleta o Banco de dados e o Usuário caso já existam.

DROP DATABASE IF EXISTS uvv;
DROP ROLE IF EXISTS lucas;

-- Cria o Usuário com senha.
CREATE USER lucas WITH 
CREATEDB
ENCRYPTED PASSWORD '123';

-- Cria um Banco de dados.

CREATE DATABASE uvv WITH 
OWNER = 'lucas' 
template = template0 
encoding = 'UTF8' 
lc_collate = 'pt_BR.UTF-8' 
lc_ctype = 'pt_BR.UTF-8' 
;

-- Se conecta a esse banco de dados e ao usuário.

\c "dbname=uvv user=lucas password=123"

-- Cria o Schema Elmasri.

CREATE SCHEMA elmasri AUTHORIZATION lucas;

-- Direciona o caminho para o Schema do Elmasri.

ALTER USER lucas
SET SEARCH_PATH TO elmasri, "$user", public;

SET SEARCH_PATH TO elmasri, "$user", public;

-- Criação de tabelas.

-- Cria a tabela Funcionário.

CREATE TABLE elmasri.funcionario (
                cpf                 CHAR(11)       NOT NULL,
                primeiro_nome       VARCHAR(15)    NOT NULL,
                nome_meio           CHAR(1),
                ultimo_nome         VARCHAR(15)    NOT NULL,
                data_nascimento     DATE,
                endereco            VARCHAR(50),
                sexo                CHAR(1)                  CHECK (sexo = 'M' or sexo = 'F'),
                salario             NUMERIC(10,2)            CHECK (salario >= 0),
                cpf_supervisor      CHAR(11)       NOT NULL,
                numero_departamento INTEGER        NOT NULL              
);

-- Comentários na tabela Funcionário.

COMMENT ON TABLE  elmasri.funcionario                     IS 'Tabela que armazena as informacoes dos funcionarios.';
COMMENT ON COLUMN elmasri.funcionario.cpf                 IS 'CPF do funcionario. Sera a PK da tabela.';
COMMENT ON COLUMN elmasri.funcionario.primeiro_nome       IS 'Primeiro nome do funcionario.';
COMMENT ON COLUMN elmasri.funcionario.nome_meio           IS 'Inicial do nome do meio.';
COMMENT ON COLUMN elmasri.funcionario.ultimo_nome         IS 'Sobrenome do funcionario.';
COMMENT ON COLUMN elmasri.funcionario.data_nascimento     IS 'Data de nascimento do funcionario.';
COMMENT ON COLUMN elmasri.funcionario.endereco            IS 'Endereco do funcionario.';
COMMENT ON COLUMN elmasri.funcionario.sexo                IS 'Sexo do funcionario.';
COMMENT ON COLUMN elmasri.funcionario.salario             IS 'Salario do funcionario.';
COMMENT ON COLUMN elmasri.funcionario.cpf_supervisor      IS 'CPF do supervisor.';
COMMENT ON COLUMN elmasri.funcionario.numero_departamento IS 'Numero do departamento do funcionario.';

-- Chaves na tabela Funcionário.

ALTER TABLE funcionario ADD CONSTRAINT pk_funcionario
PRIMARY KEY (cpf);

ALTER TABLE elmasri.funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES elmasri.funcionario (cpf);

-- Cria a tabela Departamento.

CREATE TABLE elmasri.departamento (
                numero_departamento INTEGER     NOT NULL,
                nome_departamento   VARCHAR(15) NOT NULL,
                cpf_gerente         CHAR(11)    NOT NULL,
                data_inicio_gerente DATE
);

-- Chaves na tabela Departamento.

ALTER TABLE departamento ADD CONSTRAINT pk_departamento
PRIMARY KEY (numero_departamento);

ALTER TABLE elmasri.departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES elmasri.funcionario (cpf);

CREATE UNIQUE INDEX departamento_idx
ON elmasri.departamento
( nome_departamento );

-- Comentários na tabela Departamento.

COMMENT ON TABLE  elmasri.departamento                     IS 'Tabela que armazena as informacoes dos departamentos.';
COMMENT ON COLUMN elmasri.departamento.numero_departamento IS 'Numero do departamento. E a PK desta tabela.';
COMMENT ON COLUMN elmasri.departamento.nome_departamento   IS 'Nome do departamento. Deve ser unico.';
COMMENT ON COLUMN elmasri.departamento.cpf_gerente         IS 'CPF do gerente do departamento. E uma FK para a tabela funcionarios.';
COMMENT ON COLUMN elmasri.departamento.data_inicio_gerente IS 'Data do inicio do gerente no departamento.';

-- Cria a tabela Projeto.

CREATE TABLE elmasri.projeto (
                numero_projeto      INTEGER     NOT NULL,
                nome_projeto        VARCHAR(20) NOT NULL,
                local_projeto       VARCHAR(15),
                numero_departamento INTEGER     NOT NULL
);

-- Chaves na tabela Projeto.

ALTER TABLE projeto ADD CONSTRAINT pk_projeto 
PRIMARY KEY (numero_projeto);

ALTER TABLE elmasri.projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento);

CREATE UNIQUE INDEX projeto_idx
ON elmasri.projeto
( nome_projeto );

-- Comentários na tabela Projeto.

COMMENT ON TABLE  elmasri.projeto                     IS 'Tabela que armazena as informacoes sobre os projetos dos departamentos.';
COMMENT ON COLUMN elmasri.projeto.numero_projeto      IS 'Numero do projeto. E a PK desta tabela.';
COMMENT ON COLUMN elmasri.projeto.nome_projeto        IS 'Nome do projeto. Deve ser unico.';
COMMENT ON COLUMN elmasri.projeto.local_projeto       IS 'Localizacao do projeto.';
COMMENT ON COLUMN elmasri.projeto.numero_departamento IS 'Numero do departamento. E uma FK para a tabela departamento.';

-- Cria a tabela Localizações de departamento.

CREATE TABLE elmasri.localizacoes_departamento (
                numero_departamento INTEGER       NOT NULL,
                local               VARCHAR(15)   NOT NULL
);

-- Chaves na tabela Localizações de departamento.

ALTER TABLE localizacoes_departamento ADD CONSTRAINT pk_localizacoes_departamento
PRIMARY KEY (numero_departamento, local);

ALTER TABLE elmasri.localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento);

-- Comentários na tabela Localizações de departamento.

COMMENT ON TABLE  elmasri.localizacoes_departamento                     IS 'Tabela que armazena as possiveis localizacoes dos departamentos.';
COMMENT ON COLUMN elmasri.localizacoes_departamento.numero_departamento IS 'Numero do departamento. Faz parta da PK desta tabela e tambem e uma FK para a tabela departamento.';
COMMENT ON COLUMN elmasri.localizacoes_departamento.local               IS 'Localizacao do departamento. Faz parte da PK desta tabela.';

-- Cria a tabela Dependente.

CREATE TABLE elmasri.dependente (
                cpf_funcionario CHAR(11)    NOT NULL,
                nome_dependente VARCHAR(15) NOT NULL,
                sexo            CHAR(1)               CHECK (sexo = 'M' or sexo = 'F'),
                data_nascimento DATE,
                parentesco      VARCHAR(15)
);

-- Chaves na tabela Dependente.

ALTER TABLE dependente ADD CONSTRAINT pk_dependente
PRIMARY KEY (cpf_funcionario, nome_dependente);

ALTER TABLE elmasri.dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf);

-- Comentários na tabela Dependente.

COMMENT ON TABLE  elmasri.dependente                 IS 'Tabela que armazena as informacoes dos dependentes dos funcionarios.';
COMMENT ON COLUMN elmasri.dependente.cpf_funcionario IS 'CPF do funcionario. Faz parte da PK desta tabela e e uma FK para a tabela funcionario.';
COMMENT ON COLUMN elmasri.dependente.nome_dependente IS 'Nome do dependente. Faz parte da PK desta tabela.';
COMMENT ON COLUMN elmasri.dependente.sexo            IS 'Sexo do dependente.';
COMMENT ON COLUMN elmasri.dependente.data_nascimento IS 'Data de nascimento do dependente.';
COMMENT ON COLUMN elmasri.dependente.parentesco      IS 'Descricao do parentesco do dependente com o funcionario.';

-- Cria a tabela Trabalha em.

CREATE TABLE elmasri.trabalha_em (
                cpf_funcionario CHAR(11)     NOT NULL,
                numero_projeto  INTEGER      NOT NULL,
                horas           NUMERIC(3,1) NOT NULL  CHECK (horas >= 0)
);

-- Chaves na tabela Trabalha em.

ALTER TABLE trabalha_em ADD CONSTRAINT pk_trabalha_em
PRIMARY KEY (cpf_funcionario, numero_projeto);

ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf);

ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES elmasri.projeto (numero_projeto);

-- Comentários na tabela Trabalha em.

COMMENT ON TABLE  elmasri.trabalha_em                 IS 'Tabela para armazenar quais funcionarios trabalham em quais projetos.';
COMMENT ON COLUMN elmasri.trabalha_em.cpf_funcionario IS 'CPF do funcionario. Faz parte da PK desta tabela e e uma FK para a tabela funcionario.';
COMMENT ON COLUMN elmasri.trabalha_em.numero_projeto  IS 'Numero do projeto. Faz parte da PK desta tabela e e uma FK para a tabela projeto.';
COMMENT ON COLUMN elmasri.trabalha_em.horas           IS 'Horas trabalhadas pelo funcionario neste projeto.';

-- Fim da criação de tabelas.

-----

-- Alterações nos erros do modelo inicial do Elmasri.

-- Exclusão da restrição "NOT NULL"

ALTER TABLE elmasri.funcionario ALTER COLUMN cpf_supervisor DROP NOT NULL;

-- Exclusão da restrição "NOT NULL"
               
ALTER TABLE elmasri.trabalha_em ALTER COLUMN horas DROP NOT NULL;

-----

-- Fim das alterações nos erros do modelo inicial do Elmasri.

-- Inserção de dados nas tabelas.

-- Inserção de dados na tabela Funcionário.

INSERT INTO elmasri.funcionario
(cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
VALUES
('88866555576', 'Jorge', 'E', 'Brito', '1937-11-10', 'Rua do Horto, 35, São Paulo, SP', 'M', 55000.00, null, 1),
('33344555587', 'Fernando', 'T', 'Wong', '1955-12-08', 'Rua da Lapa, 34, São Paulo, SP', 'M', 40000.00, '88866555576', 5),
('98765432168', 'Jennifer', 'S', 'Souza', '1941-06-20', 'Av.Arthur, 54, Santo André, SP', 'F', 43000.00, '88866555576', 4),
('12345678966', 'João', 'B', 'Silva', '1965-01-09', 'Rua das Flores, 751, São Paulo, SP', 'M', 30000.00, '33344555587', 5),
('66688444476', 'Ronaldo', 'K', 'Lima', '1962-09-15', 'Rua Rebouças, 65, Piracicaba, SP', 'M', 38000.00, '33344555587', 5),
('45345345376', 'Joice', 'A', 'Leite', '1972-07-31', 'Av.Lucas Obes, 74, São Paulo, SP', 'F', 25000.00, '33344555587', 5),
('99988777767', 'Alice', 'J', 'Zelaya', '1968-01-19', 'Rua Souza Lima, 35, Curitiba, PR', 'F', 25000.00, '98765432168', 4),
('98798798733', 'André', 'V', 'Pereira', '1969-03-29', 'Rua Timbira, 35, São Paulo, SP', 'M', 25000.00, '98765432168', 4);

-- Inserção de dados na tabela Departamento.

INSERT INTO elmasri.departamento 
(numero_departamento, nome_departamento, cpf_gerente, data_inicio_gerente) 
VALUES
(5, 'Pesquisa', '33344555587', '1988-05-22'),
(4, 'Administração', '98765432168', '1995-01-01'),
(1, 'Matriz', '88866555576', '1981-06-19');

-- Inserção de dados na tabela Localizações de departamento.

INSERT INTO elmasri.localizacoes_departamento 
(numero_departamento, "local")
VALUES
(1, 'São Paulo'),
(4, 'Mauá'),
(5, 'Santo André'),
(5, 'Itu'),
(5, 'São Paulo');

-- Inserção de dados na tabela Projeto.

INSERT INTO elmasri.projeto
(numero_projeto, nome_projeto, local_projeto, numero_departamento)
VALUES
(1, 'ProdutoX', 'Santo André', 5),
(2, 'ProdutoY', 'Itu', 5),
(3, 'ProdutoZ', 'São Paulo', 5),
(10, 'Informatização', 'Mauá', 4),
(20, 'Reorganização', 'São Paulo', 1),
(30, 'Novos Beneficios', 'Mauá', 4);

-- Inserção de dados na tabela Dependente.

INSERT INTO elmasri.dependente 
(cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
VALUES
('33344555587', 'Alice', 'F', '1987-04-05', 'Filha'),
('33344555587', 'Tiago', 'M', '1983-10-25', 'Filho'),
('33344555587', 'Janaína', 'F', '1958-05-03', 'Esposa'),
('98765432168', 'Antonio', 'M', '1942-02-28', 'Marido'),
('12345678966', 'Michael', 'M', '1988-01-04', 'Filho'),
('12345678966', 'Alicia', 'F', '1988-12-30', 'Filha'),
('12345678966', 'Elizabeth', 'F', '1967-05-05', 'Esposa');

-- Inserção de dados na tabela Trabalha em.

INSERT INTO elmasri.trabalha_em 
(cpf_funcionario, numero_projeto,horas)
VALUES
('12345678966', 1, '32.50'),
('12345678966', 2, '07.50'),
('66688444476', 3, '40.00'),
('45345345376', 1, '20.00'),
('45345345376', 2, '20.00'),
('33344555587', 2, '10.00'),
('33344555587', 3, '10.00'),
('33344555587', 10, '10.00'),
('33344555587', 20, '10.00'),
('99988777767', 30, '30.00'),
('99988777767', 10, '10.00'),
('98798798733', 10, '35.00'),
('98798798733', 30, '05.00'),
('98765432168', 30, '20.00'),
('98765432168', 20, '15.00'),
('88866555576', 20, null);

-- Fim do arquivo SQL para o PostgreSQL.
