
CREATE TABLE public.imagem_fundo (
                cod_imagem_fundo VARCHAR(30) NOT NULL,
                tipo VARCHAR(50) NOT NULL,
                CONSTRAINT pk_imagem_fundo PRIMARY KEY (cod_imagem_fundo)
);
COMMENT ON TABLE public.imagem_fundo IS 'Tabela sobre imagens de fundo.';
COMMENT ON COLUMN public.imagem_fundo.cod_imagem_fundo IS 'Código identificador das imagens de fundo.';
COMMENT ON COLUMN public.imagem_fundo.tipo IS 'Tipo de imagem de fundo.';


CREATE TABLE public.cores (
                cod_cor VARCHAR(12) NOT NULL,
                tipo VARCHAR(50) NOT NULL,
                CONSTRAINT pk_cores PRIMARY KEY (cod_cor)
);
COMMENT ON TABLE public.cores IS 'Tabela sobre as cores do jogo.';
COMMENT ON COLUMN public.cores.cod_cor IS 'Código identificador da cor.';
COMMENT ON COLUMN public.cores.tipo IS 'Tipo de cor.';


CREATE TABLE public.configuracoes (
                cod_config INTEGER NOT NULL,
                volume INTEGER NOT NULL,
                brilho INTEGER NOT NULL,
                cod_cor VARCHAR(12) NOT NULL,
                cod_imagem_fundo VARCHAR(30) NOT NULL,
                CONSTRAINT pk_configuracoes PRIMARY KEY (cod_config)
);
COMMENT ON TABLE public.configuracoes IS 'Configurações do jogo.';
COMMENT ON COLUMN public.configuracoes.cod_config IS 'Código identificador da configurações.';
COMMENT ON COLUMN public.configuracoes.volume IS 'Volume do jogo.';
COMMENT ON COLUMN public.configuracoes.cod_cor IS 'Código identificador da cor.';
COMMENT ON COLUMN public.configuracoes.cod_imagem_fundo IS 'Código identificador da imagem de fundo.';


CREATE TABLE public.personalizacoes (
                cod_personalizacoes INTEGER NOT NULL,
                data_configuracao DATE NOT NULL,
                hora INTEGER NOT NULL,
                cor VARCHAR(12) NOT NULL,
                brilho INTEGER NOT NULL,
                som INTEGER NOT NULL,
                imagem VARCHAR(30) NOT NULL,
                cod_config INTEGER NOT NULL,
                CONSTRAINT pk_personalizacoes PRIMARY KEY (cod_personalizacoes)
);
COMMENT ON TABLE public.personalizacoes IS 'Personalizações do usuário sobre o jogo.';
COMMENT ON COLUMN public.personalizacoes.cod_personalizacoes IS 'Código identificador da personalização do jogo.';
COMMENT ON COLUMN public.personalizacoes.data_configuracao IS 'Data configurada.';
COMMENT ON COLUMN public.personalizacoes.hora IS 'Hora configurada.';
COMMENT ON COLUMN public.personalizacoes.cor IS 'Cor configurada.';
COMMENT ON COLUMN public.personalizacoes.brilho IS 'Brilho configurado.';
COMMENT ON COLUMN public.personalizacoes.som IS 'Som configurado.';
COMMENT ON COLUMN public.personalizacoes.imagem IS 'Configurações de imagem.';
COMMENT ON COLUMN public.personalizacoes.cod_config IS 'Código identificador da configuração.';


CREATE TABLE public.jogadores (
                cod_jogador INTEGER NOT NULL,
                nome VARCHAR(50) NOT NULL,
                apelido VARCHAR(20) NOT NULL,
                imagem VARCHAR(30) NOT NULL,
                data_registro DATE NOT NULL,
                localizacao VARCHAR,
                CONSTRAINT pk_jogadores PRIMARY KEY (cod_jogador)
);
COMMENT ON TABLE public.jogadores IS 'Tabela referente ao cadastro/identidade dos jogadores.';
COMMENT ON COLUMN public.jogadores.cod_jogador IS 'Código identificador do jogador.';
COMMENT ON COLUMN public.jogadores.nome IS 'Nome do jogador.';
COMMENT ON COLUMN public.jogadores.apelido IS 'Apelido do jogador.';
COMMENT ON COLUMN public.jogadores.data_registro IS 'Data em que o jogador foi registrado.';
COMMENT ON COLUMN public.jogadores.localizacao IS 'Localização do jogador.';


CREATE TABLE public.valencia (
                cod_valencia INTEGER NOT NULL,
                tipo VARCHAR NOT NULL,
                CONSTRAINT pk_valencia PRIMARY KEY (cod_valencia)
);
COMMENT ON TABLE public.valencia IS 'Tabela referente a valência.';
COMMENT ON COLUMN public.valencia.tipo IS 'Tipo da valência.';


CREATE TABLE public.trilha_sonora (
                cod_trilha_sonora INTEGER NOT NULL,
                nome VARCHAR(50) NOT NULL,
                cod_valencia INTEGER NOT NULL,
                CONSTRAINT pk_trilha_sonora PRIMARY KEY (cod_trilha_sonora)
);
COMMENT ON TABLE public.trilha_sonora IS 'Tabela sobre a trilha sonora do jogo.';
COMMENT ON COLUMN public.trilha_sonora.cod_trilha_sonora IS 'Código identificador da trilha sonora do jogo.';
COMMENT ON COLUMN public.trilha_sonora.nome IS 'Nome da trilha sonora.';
COMMENT ON COLUMN public.trilha_sonora.cod_valencia IS 'Código identificador da valência da trilha sonora.';


CREATE TABLE public.objetos (
                cod_objeto INTEGER NOT NULL,
                nome VARCHAR(50) NOT NULL,
                descricao VARCHAR(100) NOT NULL,
                CONSTRAINT pk_objetos PRIMARY KEY (cod_objeto)
);
COMMENT ON TABLE public.objetos IS 'Objetos presentes no cenário do jogo.';
COMMENT ON COLUMN public.objetos.cod_objeto IS 'Código identificador do objeto.';
COMMENT ON COLUMN public.objetos.nome IS 'Nome do objeto.';
COMMENT ON COLUMN public.objetos.descricao IS 'Descrição referente ao objeto.';


CREATE TABLE public.jogos (
                cod_jogos INTEGER NOT NULL,
                nome VARCHAR(50) NOT NULL,
                objetivo VARCHAR(50) NOT NULL,
                numero_niveis INTEGER NOT NULL,
                data_criacao DATE NOT NULL,
                cod_personalizacoes INTEGER NOT NULL,
                CONSTRAINT pk_jogos PRIMARY KEY (cod_jogos)
);
COMMENT ON TABLE public.jogos IS 'Tabela referente aos jogos.';
COMMENT ON COLUMN public.jogos.cod_jogos IS 'Código identificador dos jogos.';
COMMENT ON COLUMN public.jogos.nome IS 'Nome do jogo.';
COMMENT ON COLUMN public.jogos.objetivo IS 'Objetivo do jogo.';
COMMENT ON COLUMN public.jogos.numero_niveis IS 'Número de níveis no jogo.';
COMMENT ON COLUMN public.jogos.data_criacao IS 'Data de criação do jogo.';
COMMENT ON COLUMN public.jogos.cod_personalizacoes IS 'Código identificador da personalização dos jogos.';


CREATE TABLE public.missoes (
                cod_missoes INTEGER NOT NULL,
                nome VARCHAR(50) NOT NULL,
                descricao_missao VARCHAR(100) NOT NULL,
                tempo_max INTEGER,
                pontuacao INTEGER NOT NULL,
                CONSTRAINT pk_missoes PRIMARY KEY (cod_missoes)
);
COMMENT ON TABLE public.missoes IS 'Missões do jogo';
COMMENT ON COLUMN public.missoes.cod_missoes IS 'Código identificador das missões.';
COMMENT ON COLUMN public.missoes.nome IS 'Nome das missões.';
COMMENT ON COLUMN public.missoes.descricao_missao IS 'Descrição das missões.';
COMMENT ON COLUMN public.missoes.tempo_max IS 'Tempo máximo das missões.';
COMMENT ON COLUMN public.missoes.pontuacao IS 'Pontuação das missões.';


CREATE TABLE public.niveis (
                cod_nivel INTEGER NOT NULL,
                nome VARCHAR(50) NOT NULL,
                objetivo VARCHAR(50) NOT NULL,
                cod_missoes INTEGER NOT NULL,
                cod_jogos INTEGER NOT NULL,
                cod_trilha_sonora INTEGER NOT NULL,
                CONSTRAINT pk_niveis PRIMARY KEY (cod_nivel)
);
COMMENT ON TABLE public.niveis IS 'Tabela que informa os niveis do jogo e o que eles possuem.';
COMMENT ON COLUMN public.niveis.cod_nivel IS 'Código identificador do nível do jogo.';
COMMENT ON COLUMN public.niveis.nome IS 'Nome do nível presente.';
COMMENT ON COLUMN public.niveis.objetivo IS 'Objetivo do nivel.';
COMMENT ON COLUMN public.niveis.cod_missoes IS 'Código identificador da missao do nível.';
COMMENT ON COLUMN public.niveis.cod_jogos IS 'Código identificador dos jogos.';
COMMENT ON COLUMN public.niveis.cod_trilha_sonora IS 'Código identificador da trilha sonora do nível.';


CREATE TABLE public.partidas (
                cod_nivel INTEGER NOT NULL,
                data_inicio DATE NOT NULL,
                data_fim DATE NOT NULL,
                hora_inicio INTEGER NOT NULL,
                hora_fim INTEGER NOT NULL,
                pontuacao INTEGER NOT NULL,
                cod_jogador INTEGER NOT NULL,
                CONSTRAINT pk_partidas PRIMARY KEY (cod_nivel)
);
COMMENT ON TABLE public.partidas IS 'Tabela referente as partidas e suas regras para seu funcionamento.';
COMMENT ON COLUMN public.partidas.cod_nivel IS 'Código identificador do nível das partidas.';
COMMENT ON COLUMN public.partidas.data_inicio IS 'Data de início da partida.';
COMMENT ON COLUMN public.partidas.data_fim IS 'Data do término da partida.';
COMMENT ON COLUMN public.partidas.hora_inicio IS 'Horário de início da partida.';
COMMENT ON COLUMN public.partidas.hora_fim IS 'Horário do término da partida.';
COMMENT ON COLUMN public.partidas.pontuacao IS 'Pontuação efetuada pelos jogadores.';
COMMENT ON COLUMN public.partidas.cod_jogador IS 'Código identificador do jogador.';


CREATE TABLE public.composicoes (
                cod_nivel INTEGER NOT NULL,
                cod_objeto INTEGER NOT NULL,
                posicao_inicial INTEGER NOT NULL,
                pontos INTEGER NOT NULL,
                CONSTRAINT pk_composicoes PRIMARY KEY (cod_nivel, cod_objeto)
);
COMMENT ON TABLE public.composicoes IS 'Tabela referente as composições do jogo.';
COMMENT ON COLUMN public.composicoes.cod_nivel IS 'Código identificador do nível.';
COMMENT ON COLUMN public.composicoes.cod_objeto IS 'Código identificador dos objetos.';
COMMENT ON COLUMN public.composicoes.posicao_inicial IS 'Posição inicial do shwernous.';
COMMENT ON COLUMN public.composicoes.pontos IS 'Pontuação.';


CREATE TABLE public.personagens (
                cod_personagem INTEGER NOT NULL,
                nome VARCHAR(50) NOT NULL,
                imagem VARCHAR NOT NULL,
                cod_nivel INTEGER NOT NULL,
                CONSTRAINT pk_personagens PRIMARY KEY (cod_personagem)
);
COMMENT ON TABLE public.personagens IS 'Personagens dentro do jogo.';
COMMENT ON COLUMN public.personagens.cod_personagem IS 'Código identificador dos personagens.';
COMMENT ON COLUMN public.personagens.nome IS 'Nome do personagem.';
COMMENT ON COLUMN public.personagens.imagem IS 'Imagem do personagem.';
COMMENT ON COLUMN public.personagens.cod_nivel IS 'Código referente ao nível atual do personagem.';


CREATE TABLE public.cenarios (
                cod_cenario INTEGER NOT NULL,
                nome VARCHAR(50) NOT NULL,
                tema VARCHAR(30) NOT NULL,
                cod_nivel INTEGER NOT NULL,
                CONSTRAINT pk_cenarios PRIMARY KEY (cod_cenario)
);
COMMENT ON TABLE public.cenarios IS 'Cenários do jogo.';
COMMENT ON COLUMN public.cenarios.cod_cenario IS 'Código identificador do cenário.';
COMMENT ON COLUMN public.cenarios.nome IS 'Nome do cenário.';
COMMENT ON COLUMN public.cenarios.tema IS 'Tema do cenário.';
COMMENT ON COLUMN public.cenarios.cod_nivel IS 'Código identificador do nível.';


ALTER TABLE public.configuracoes ADD CONSTRAINT imagem_fundo_configuracoes_fk
FOREIGN KEY (cod_imagem_fundo)
REFERENCES public.imagem_fundo (cod_imagem_fundo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.configuracoes ADD CONSTRAINT cores_configuracoes_fk
FOREIGN KEY (cod_cor)
REFERENCES public.cores (cod_cor)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.personalizacoes ADD CONSTRAINT configuracoes_personalizacoes_fk
FOREIGN KEY (cod_config)
REFERENCES public.configuracoes (cod_config)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.jogos ADD CONSTRAINT personalizacoes_jogos_fk
FOREIGN KEY (cod_personalizacoes)
REFERENCES public.personalizacoes (cod_personalizacoes)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.partidas ADD CONSTRAINT jogadores_partidas_fk
FOREIGN KEY (cod_jogador)
REFERENCES public.jogadores (cod_jogador)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.trilha_sonora ADD CONSTRAINT valencia_trilha_sonora_fk
FOREIGN KEY (cod_valencia)
REFERENCES public.valencia (cod_valencia)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.niveis ADD CONSTRAINT trilha_sonora_niveis_fk
FOREIGN KEY (cod_trilha_sonora)
REFERENCES public.trilha_sonora (cod_trilha_sonora)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.composicoes ADD CONSTRAINT objetos_composicoes_fk
FOREIGN KEY (cod_objeto)
REFERENCES public.objetos (cod_objeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.niveis ADD CONSTRAINT jogos_niveis_fk
FOREIGN KEY (cod_jogos)
REFERENCES public.jogos (cod_jogos)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.niveis ADD CONSTRAINT missoes_niveis_fk
FOREIGN KEY (cod_missoes)
REFERENCES public.missoes (cod_missoes)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.cenarios ADD CONSTRAINT niveis_cenarios_fk
FOREIGN KEY (cod_nivel)
REFERENCES public.niveis (cod_nivel)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.personagens ADD CONSTRAINT niveis_personagens_fk
FOREIGN KEY (cod_nivel)
REFERENCES public.niveis (cod_nivel)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.composicoes ADD CONSTRAINT niveis_composicoes_fk
FOREIGN KEY (cod_nivel)
REFERENCES public.niveis (cod_nivel)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.partidas ADD CONSTRAINT niveis_partidas_fk
FOREIGN KEY (cod_nivel)
REFERENCES public.niveis (cod_nivel)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
