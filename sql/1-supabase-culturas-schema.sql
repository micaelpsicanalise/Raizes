-- ==========================================================
-- Culturas afro-diaspóricas — tabela nova + link em "guias"
-- Rodar no SQL Editor do projeto Supabase (aewcxqzpbipwcdpsjfht).
-- ==========================================================

create table if not exists public.culturas (
  id            uuid primary key default gen_random_uuid(),
  nome          text not null,
  slug          text unique not null,
  regiao_origem text,
  periodo       text,
  resumo        text,
  marcos        jsonb not null default '[]'::jsonb,  -- [{ "ano": "Séc. XIX", "texto": "..." }, ...]
  ordem         int not null default 0,
  ativo         boolean not null default true,
  created_at    timestamptz not null default now()
);

-- link opcional de cada guia à cultura de origem (substitui a
-- necessidade de digitar isso como texto livre no campo "categoria")
alter table public.guias
  add column if not exists origem_cultural_id uuid references public.culturas(id) on delete set null;

-- RLS: leitura pública (o app consome sem login), escrita só admin
alter table public.culturas enable row level security;

drop policy if exists "culturas_select_public" on public.culturas;
create policy "culturas_select_public"
  on public.culturas for select
  using (true);

drop policy if exists "culturas_write_admin" on public.culturas;
create policy "culturas_write_admin"
  on public.culturas for all
  using (auth.uid() = 'af619e44-1049-4ebd-86b4-4b4fa3bce94b')
  with check (auth.uid() = 'af619e44-1049-4ebd-86b4-4b4fa3bce94b');

-- Sementes iniciais (pode editar/apagar depois pelo admin)
insert into public.culturas (nome, slug, regiao_origem, periodo, resumo, marcos, ordem) values
(
  'Nagô / Iorubá',
  'ioruba',
  'Sudoeste da Nigéria e Benin',
  'Trazida ao Brasil sobretudo entre 1750–1850',
  'Tradição de matriz iorubá que chegou ao Brasil com pessoas escravizadas da região onde hoje ficam Nigéria e Benin. Trouxe o culto aos orixás, hoje central no Candomblé e na Umbanda.',
  '[
    {"ano":"Séc. XVIII–XIX","texto":"Chegada forçada de povos iorubás ao Brasil durante o tráfico transatlântico."},
    {"ano":"Séc. XIX","texto":"Formação dos primeiros terreiros de Candomblé Queto/Nagô na Bahia."},
    {"ano":"1900–1930","texto":"Elementos do culto aos orixás são incorporados à Umbanda nascente no Rio de Janeiro."}
  ]'::jsonb,
  1
),
(
  'Banto (Angola e Congo)',
  'banto',
  'África Centro-Ocidental (atuais Angola, Congo, RD Congo)',
  'Um dos grupos mais numerosos trazidos ao Brasil, do séc. XVI ao XIX',
  'Povos de língua banto formaram um dos maiores contingentes da diáspora africana no Brasil. Sua cosmologia e culto aos ancestrais influenciam o Candomblé de Angola e a figura dos Pretos-velhos na Umbanda.',
  '[
    {"ano":"Séc. XVI","texto":"Início do tráfico entre os reinos do Congo/Angola e o Brasil colonial."},
    {"ano":"Séc. XVIII","texto":"Formação de quilombos com forte presença banto, como Palmares."},
    {"ano":"Séc. XX","texto":"A figura do Preto-velho consolida-se na Umbanda como memória dos ancestrais africanos escravizados."}
  ]'::jsonb,
  2
),
(
  'Jeje (povo Fon)',
  'jeje',
  'Antigo Reino do Daomé (atual Benin)',
  'Chegada intensificada no séc. XVIII e início do XIX',
  'Povos fon do antigo Daomé trouxeram o culto aos voduns, divindades próximas em função aos orixás iorubás. O Jeje formou, com o Nagô e o Banto, uma das três grandes matrizes das religiões afro-brasileiras — e é raiz direta do Vodum praticado no Haiti.',
  '[
    {"ano":"Séc. XVIII","texto":"Guerras no Daomé aumentam o número de pessoas escravizadas enviadas às Américas."},
    {"ano":"Séc. XIX","texto":"Terreiros jeje-nagô se consolidam no Maranhão e na Bahia."}
  ]'::jsonb,
  3
),
(
  'Diáspora cubana e a Santería',
  'diaspora-cubana',
  'Cuba, a partir de povos iorubás escravizados',
  'Consolidada no séc. XIX, sob forte repressão colonial',
  'Na diáspora cubana, o culto iorubá aos orixás se reorganizou sob a repressão colonial disfarçado atrás dos santos católicos — daí o nome Santería (ou Regla de Ocha). Compartilha raiz direta com o Candomblé Nagô brasileiro.',
  '[
    {"ano":"Séc. XIX","texto":"Sincretismo forçado entre orixás iorubás e santos católicos em Cuba."},
    {"ano":"Séc. XX","texto":"Expansão da Santería com a diáspora cubana pelas Américas."}
  ]'::jsonb,
  4
),
(
  'Formação da Umbanda no Brasil',
  'formacao-umbanda',
  'Rio de Janeiro e Sudeste do Brasil',
  'A partir de 1908, consolidada nas décadas de 1920–1930',
  'A Umbanda nasce da mistura das tradições africanas (iorubá, banto, jeje) com o catolicismo popular, o espiritismo kardecista e elementos indígenas — uma religião genuinamente brasileira, criada em resposta direta à experiência da diáspora.',
  '[
    {"ano":"1908","texto":"Zélio de Moraes recebe, no Rio de Janeiro, o que a tradição narra como a primeira gira de Umbanda."},
    {"ano":"1920–1930","texto":"Expansão dos primeiros terreiros e organização das linhas de trabalho."},
    {"ano":"Hoje","texto":"A Umbanda segue viva como espaço de memória e reafirmação das culturas afro-diaspóricas no Brasil."}
  ]'::jsonb,
  5
)
on conflict (slug) do nothing;
