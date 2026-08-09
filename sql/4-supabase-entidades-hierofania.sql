-- ==========================================================
-- Entidades por cultura + elementos de hierofania
-- Reorganiza "guias" (agora tratados como Entidades no app) em
-- torno da cultura de origem e de uma classificação etnográfica
-- fixa, e adiciona os elementos de hierofania (como a entidade se
-- manifesta: cor, elemento, dia, saudação etc).
-- Roda depois dos SQLs de culturas.
-- ==========================================================

-- Classificação etnográfica fixa (substitui o texto livre em "categoria")
alter table public.guias
  add column if not exists classificacao text;

-- Elementos de hierofania — lista de {label, valor}, mesmo formato
-- usado em "marcos" nas culturas: um por linha no admin, "label | valor".
alter table public.guias
  add column if not exists hierofania jsonb not null default '[]'::jsonb;

comment on column public.guias.classificacao is
  'Uma de: divindade | ancestral | espirito-natureza | guardiao | mestre | crianca';
comment on column public.guias.hierofania is
  'Elementos de manifestação do sagrado: [{"label":"Cor","valor":"Vermelho e branco"}, ...]';

-- Os campos antigos "categoria" (texto livre) e "grupo" (principal/
-- auxiliar) continuam existindo na tabela — não apagamos dado — mas
-- o admin e o app não usam mais eles: "classificacao" e "origem_
-- cultural_id" tomaram esse lugar.

-- Não há mais pontos cantados nem orações — só contos (itãs) seguem
-- como conteúdo de texto. Se você já tinha algum conteúdo do tipo
-- "ponto" ou "oracao" cadastrado, isso só desativa a exibição no
-- app (não apaga nada, dá pra reverter mudando "ativo" de volta):
update public.conteudos
  set ativo = false
  where tipo in ('ponto', 'oracao');
