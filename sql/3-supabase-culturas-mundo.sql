-- ==========================================================
-- Mapa mundial de povos originários — expande "culturas" pra
-- cobrir o mundo todo, com posição continental e rotas de
-- migração/transmissão entre continentes.
-- Roda depois de supabase-culturas-schema.sql e
-- supabase-culturas-adicionais.sql (precisa da tabela "culturas"
-- já existir com as 17 linhas anteriores).
-- ==========================================================

-- 1) Campo de continente/região, usado pra posicionar cada
--    cultura no mapa esquemático do app.
alter table public.culturas
  add column if not exists continente text;

-- valores esperados (o app já sabe posicionar exatamente estes 9):
--   america-norte | america-central-caribe | america-sul
--   europa | africa | oriente-medio | siberia | asia | oceania

-- 2) Rotas de migração/transmissão entre continentes — dados,
--    não código, pra poder editar pelo admin sem mexer no app.
create table if not exists public.culturas_migracoes (
  id                  uuid primary key default gen_random_uuid(),
  nome                text not null,
  continente_origem   text not null,
  continente_destino  text not null,
  descricao           text,
  ordem               int not null default 0,
  ativo               boolean not null default true,
  created_at          timestamptz not null default now()
);

alter table public.culturas_migracoes enable row level security;

drop policy if exists "migracoes_select_public" on public.culturas_migracoes;
create policy "migracoes_select_public"
  on public.culturas_migracoes for select
  using (true);

drop policy if exists "migracoes_write_admin" on public.culturas_migracoes;
create policy "migracoes_write_admin"
  on public.culturas_migracoes for all
  using (auth.uid() = 'af619e44-1049-4ebd-86b4-4b4fa3bce94b')
  with check (auth.uid() = 'af619e44-1049-4ebd-86b4-4b4fa3bce94b');

-- 3) Marca o continente das 17 culturas já cadastradas
update public.culturas set continente = 'africa'                  where slug in ('ioruba','banto','jeje');
update public.culturas set continente = 'america-sul'             where slug in ('formacao-umbanda','formacao-candomble','jurema','quimbanda','suriname','indigena-brasil');
update public.culturas set continente = 'america-central-caribe'  where slug in ('diaspora-cubana','haiti','trinidad','palo-monte','kumina','garifuna','lumbalu');
update public.culturas set continente = 'america-norte'           where slug in ('louisiana');

-- 4) Novas culturas — regiões ainda sem nenhuma entrada
insert into public.culturas (nome, slug, regiao_origem, periodo, resumo, marcos, continente, ordem) values

(
  'Haudenosaunee (Confederação Iroquesa)',
  'haudenosaunee',
  'Nordeste da América do Norte (atuais EUA e Canadá)',
  'Confederação formada por volta do séc. XV–XVI',
  'A Confederação Haudenosaunee (Iroquesa) uniu seis nações — Mohawk, Oneida, Onondaga, Cayuga, Seneca e, depois, Tuscarora — sob um sistema político com divisão de poder e conselho de mulheres anciãs que influenciou pensadores da democracia moderna, incluindo debates constitucionais nos EUA.',
  '[
    {"ano":"c. séc. XV–XVI","texto":"Formação da Grande Liga da Paz, unindo as nações fundadoras sob a Grande Lei (Gayanashagowa)."},
    {"ano":"Séc. XVIII","texto":"Papel central nas alianças e guerras coloniais na América do Norte."},
    {"ano":"Hoje","texto":"A Confederação segue politicamente ativa em território tribal nos EUA e Canadá."}
  ]'::jsonb,
  'america-norte', 18
),
(
  'Diné (Navajo)',
  'navajo',
  'Sudoeste dos EUA (Arizona, Novo México, Utah)',
  'Presença na região desde c. séc. XV',
  'O povo Diné (mais conhecido pelo nome espanhol Navajo) desenvolveu uma cosmologia própria centrada no equilíbrio (hózhǫ́) e em cerimônias de cura elaboradas, incluindo as pinturas de areia. É hoje a maior nação indígena reconhecida nos Estados Unidos em população e território.',
  '[
    {"ano":"c. séc. XV","texto":"Chegada dos ancestrais Diné ao sudoeste americano, vindos de povos atabascanos do norte."},
    {"ano":"1864","texto":"A Longa Caminhada — deportação forçada pelo governo dos EUA, um dos episódios mais traumáticos da história Diné."},
    {"ano":"Hoje","texto":"A Nação Navajo é a maior reserva indígena dos EUA em território."}
  ]'::jsonb,
  'america-norte', 19
),
(
  'Inuit',
  'inuit',
  'Ártico — Alasca, Canadá, Groenlândia',
  'Presença na região há milhares de anos',
  'Os Inuit desenvolveram um dos conjuntos de conhecimento mais especializados do planeta para sobreviver e prosperar no Ártico, com uma cosmologia centrada em espíritos da caça, do gelo e do mar, como a divindade Sedna.',
  '[
    {"ano":"Milhares de anos atrás","texto":"Expansão de povos árticos por Alasca, Canadá e Groenlândia."},
    {"ano":"Séc. XX","texto":"Impactos da colonização e políticas de assimilação nos territórios inuit."},
    {"ano":"1999","texto":"Criação do território autônomo de Nunavut, no Canadá."}
  ]'::jsonb,
  'america-norte', 20
),
(
  'Quéchua e Aimará',
  'quechua-aimara',
  'Cordilheira dos Andes — Peru, Bolívia, Equador, Chile, Argentina',
  'Quéchua consolidado como língua imperial a partir do séc. XV (Império Inca)',
  'Os povos quéchua e aimará são herdeiros diretos das grandes civilizações andinas, incluindo o Império Inca (Tawantinsuyu). Preservam até hoje cosmologias centradas na Pachamama (Mãe Terra) e em rituais agrícolas ligados ao calendário andino.',
  '[
    {"ano":"c. 1438–1533","texto":"Expansão do Império Inca, que difundiu a língua quéchua por toda a região andina."},
    {"ano":"1533","texto":"Conquista espanhola do Império Inca."},
    {"ano":"Hoje","texto":"O quéchua e o aimará seguem entre as línguas indígenas mais faladas das Américas."}
  ]'::jsonb,
  'america-sul', 21
),
(
  'Guarani',
  'guarani',
  'Bacia do Prata — Paraguai, sul do Brasil, Argentina, Bolívia',
  'Presença na região há mais de 2.000 anos',
  'O povo Guarani tem uma das cosmologias mais estudadas da América do Sul, centrada na busca da "Terra sem Males" (Yvy Marãe''ỹ) — uma jornada espiritual e territorial que segue viva na cultura guarani contemporânea.',
  '[
    {"ano":"Há mais de 2.000 anos","texto":"Expansão de povos de língua guarani pela bacia do Prata."},
    {"ano":"Séc. XVI–XVIII","texto":"Contato com colonizadores e as reduções jesuíticas no Paraguai."},
    {"ano":"Hoje","texto":"Comunidades guarani seguem presentes no Paraguai, Brasil, Argentina e Bolívia."}
  ]'::jsonb,
  'america-sul', 22
),
(
  'Povos celtas',
  'celtas',
  'Europa Ocidental — atuais Irlanda, Escócia, Gales, Bretanha, Galiza',
  'Cultura de La Tène, c. séc. V a.C. em diante',
  'Os povos celtas, antes da cristianização, cultuavam uma vasta gama de divindades ligadas à natureza, guiados por sacerdotes druidas. Festivais como Samhain e Beltane, marcando as estações do ano, sobrevivem transformados até hoje em tradições populares europeias.',
  '[
    {"ano":"c. séc. V a.C.","texto":"Florescimento da cultura de La Tène na Europa Central e Ocidental."},
    {"ano":"Séc. I a.C.–I d.C.","texto":"Conquista romana da Gália e Britânia, pressionando as práticas druídicas."},
    {"ano":"Séc. V–VIII d.C.","texto":"Cristianização gradual das ilhas britânicas e irlandesas, absorvendo e transformando festivais celtas."}
  ]'::jsonb,
  'europa', 23
),
(
  'Povos nórdicos e germânicos',
  'nordicos-germanicos',
  'Escandinávia e norte da Europa',
  'Era Viking, c. 793–1066 d.C.',
  'Antes da cristianização, os povos nórdicos e germânicos cultuavam divindades como Odin, Thor e Freyja, com uma cosmologia registrada mais tarde nas Eddas islandesas — hoje uma das mitologias pré-cristãs europeias mais documentadas.',
  '[
    {"ano":"793 d.C.","texto":"Ataque a Lindisfarne, marco tradicional do início da Era Viking."},
    {"ano":"Séc. X–XIII","texto":"Cristianização progressiva da Escandinávia."},
    {"ano":"Séc. XIII","texto":"Registro escrito das Eddas na Islândia, preservando a mitologia nórdica pré-cristã."}
  ]'::jsonb,
  'europa', 24
),
(
  'Sami',
  'sami',
  'Norte da Escandinávia e península de Kola (Sápmi)',
  'Presença na região há milhares de anos',
  'O povo Sami, indígena do extremo norte europeu, desenvolveu uma prática xamânica própria (noaidevuohta) ligada à pastorícia de renas e ao tambor sagrado, perseguida por séculos pelas igrejas nórdicas e hoje em processo de revitalização.',
  '[
    {"ano":"Séc. XVII–XVIII","texto":"Perseguição sistemática ao xamanismo sami pelas autoridades cristãs escandinavas, incluindo queima de tambores sagrados."},
    {"ano":"Séc. XX","texto":"Políticas de assimilação forçada nos países nórdicos."},
    {"ano":"Hoje","texto":"Reconhecimento crescente dos direitos e da cultura sami nos parlamentos nórdicos."}
  ]'::jsonb,
  'europa', 25
),
(
  'Povos eslavos pré-cristãos',
  'eslavos',
  'Europa Central e Oriental',
  'Até a cristianização, c. séc. IX–X d.C.',
  'Antes da cristianização, os povos eslavos cultuavam divindades como Perun (trovão) e Veles, com festivais sazonais que deixaram marcas profundas no folclore da Europa Central e Oriental até hoje.',
  '[
    {"ano":"Antes do séc. IX","texto":"Práticas religiosas eslavas pré-cristãs documentadas por cronistas vizinhos."},
    {"ano":"988 d.C.","texto":"Batismo da Rus de Kiev, marco da cristianização em larga escala dos eslavos orientais."}
  ]'::jsonb,
  'europa', 26
),
(
  'Axânti (Ashanti)',
  'axanti',
  'Atual Gana, África Ocidental',
  'Império Ashanti formado c. 1670',
  'O povo Axânti construiu um dos impérios mais organizados da África Ocidental, com o Banco de Ouro (Golden Stool) como símbolo sagrado de unidade. Sua cosmologia, centrada no deus supremo Nyame e em espíritos ancestrais, influencia práticas até hoje na diáspora caribenha.',
  '[
    {"ano":"c. 1670–1701","texto":"Formação do Império Ashanti sob o rei Osei Tutu."},
    {"ano":"Séc. XIX","texto":"Guerras anglo-ashanti contra a colonização britânica."},
    {"ano":"Hoje","texto":"A monarquia Ashanti segue existindo como autoridade tradicional em Gana."}
  ]'::jsonb,
  'africa', 27
),
(
  'Zulu',
  'zulu',
  'Sul da África (atual África do Sul)',
  'Reino Zulu unificado a partir de 1816',
  'O povo Zulu foi unificado em reino sob a liderança de Shaka Zulu no início do séc. XIX, com uma cosmologia centrada nos ancestrais (amadlozi) e no curandeiro-xamã sangoma, práticas que seguem vivas na África do Sul contemporânea.',
  '[
    {"ano":"1816","texto":"Shaka Zulu assume a liderança e inicia a unificação do reino Zulu."},
    {"ano":"1879","texto":"Guerra anglo-zulu."},
    {"ano":"Hoje","texto":"A cultura e a monarquia zulu seguem influentes na África do Sul."}
  ]'::jsonb,
  'africa', 28
),
(
  'San (povos do Kalahari)',
  'san',
  'Deserto do Kalahari — Botsuana, Namíbia, África do Sul',
  'Um dos povos com ocupação contínua mais antiga documentada, dezenas de milhares de anos',
  'Os San (por vezes chamados bosquímanos, termo hoje considerado pejorativo) são descendentes de uma das linhagens humanas mais antigas geneticamente documentadas. Sua cosmologia xamânica, centrada em transes de cura e pinturas rupestres, é uma das tradições espirituais contínuas mais antigas do mundo.',
  '[
    {"ano":"Dezenas de milhares de anos atrás","texto":"Ocupação contínua do sul da África por povos ancestrais dos San."},
    {"ano":"Séc. XIX–XX","texto":"Deslocamento e perseguição sob o colonialismo europeu no sul da África."},
    {"ano":"Hoje","texto":"Comunidades San lutam por reconhecimento de terras e preservação cultural."}
  ]'::jsonb,
  'africa', 29
),
(
  'Povos semíticos pré-islâmicos',
  'semiticos-pre-islamicos',
  'Península Arábica e Crescente Fértil',
  'Até a expansão do Islã no séc. VII d.C.',
  'Antes do Islã, os povos da Arábia cultuavam múltiplas divindades em santuários regionais — a Caaba em Meca, por exemplo, abrigava ídolos de diversas tribos antes de se tornar o centro do monoteísmo islâmico.',
  '[
    {"ano":"Antes do séc. VII d.C.","texto":"Politeísmo tribal árabe, com santuários regionais e feiras sagradas."},
    {"ano":"610–632 d.C.","texto":"Pregação de Maomé e consolidação do Islã na Península Arábica."}
  ]'::jsonb,
  'oriente-medio', 30
),
(
  'Beduínos',
  'beduinos',
  'Desertos da Arábia, Levante e norte da África',
  'Modo de vida nômade documentado desde a Antiguidade',
  'Os beduínos são povos árabes nômades do deserto, organizados em clãs e conhecidos por um código de hospitalidade e honra transmitido oralmente por gerações, preservado até hoje apesar da urbanização crescente.',
  '[
    {"ano":"Antiguidade","texto":"Primeiros registros de povos nômades do deserto arábico."},
    {"ano":"Séc. XX–XXI","texto":"Pressão crescente de fronteiras nacionais e urbanização sobre o modo de vida nômade beduíno."}
  ]'::jsonb,
  'oriente-medio', 31
),
(
  'Buriates',
  'buriates',
  'Sibéria, ao redor do lago Baikal',
  'Presença na região há séculos, sob o Império Mongol a partir do séc. XIII',
  'Os buriates, o maior grupo indígena da Sibéria, praticam uma forma de xamanismo e budismo tibetano combinados, com o lago Baikal ocupando lugar central e sagrado em sua cosmologia.',
  '[
    {"ano":"Séc. XIII","texto":"Incorporação da região ao Império Mongol."},
    {"ano":"Séc. XVII","texto":"Expansão russa até a Sibéria oriental, incorporando o território buriate."},
    {"ano":"Séc. XX","texto":"Repressão soviética às práticas xamânicas e budistas buriates."}
  ]'::jsonb,
  'siberia', 32
),
(
  'Nenets',
  'nenets',
  'Tundra ártica siberiana',
  'Presença na região há séculos',
  'Os Nenets são um povo nômade da tundra ártica siberiana, cuja vida gira em torno da criação de renas. Sua cosmologia xamânica trata a tundra, o gelo e os animais como seres com espírito próprio.',
  '[
    {"ano":"Séc. XVI–XVII","texto":"Expansão russa sobre o território nenets, gerando resistências como as \"guerras nenets\"."},
    {"ano":"Séc. XX","texto":"Coletivização soviética da pastorícia de renas, impactando profundamente o modo de vida nenets."}
  ]'::jsonb,
  'siberia', 33
),
(
  'Ainu',
  'ainu',
  'Ilha de Hokkaido, Japão, e Sacalina',
  'Cultura distinta documentada desde c. séc. XIII',
  'Os Ainu são um povo indígena do Japão, etnicamente e culturalmente distintos dos japoneses, com uma cosmologia animista centrada no urso (kamuy) como mensageiro entre o mundo espiritual e o humano. Foram alvo de políticas de assimilação forçada até o reconhecimento oficial como povo indígena em 2019.',
  '[
    {"ano":"c. séc. XIII","texto":"Consolidação da cultura ainu distinta em Hokkaido."},
    {"ano":"1899","texto":"Lei japonesa de \"proteção\" que na prática forçou a assimilação cultural ainu."},
    {"ano":"2019","texto":"Reconhecimento oficial dos Ainu como povo indígena do Japão."}
  ]'::jsonb,
  'asia', 34
),
(
  'Hmong',
  'hmong',
  'Montanhas do sul da China e Sudeste Asiático (Vietnã, Laos, Tailândia)',
  'Presença documentada há milênios no sul da China',
  'O povo Hmong preserva um xamanismo próprio, com o xamã (txiv neeb) atuando como intermediário com o mundo espiritual em rituais de cura. Após a Guerra do Vietnã, formaram também uma grande diáspora nos EUA e na Europa.',
  '[
    {"ano":"Milênios atrás","texto":"Presença hmong documentada nas montanhas do sul da China."},
    {"ano":"Séc. XVIII–XIX","texto":"Migração hmong para o Sudeste Asiático, fugindo de pressões do Império Chinês."},
    {"ano":"Pós-1975","texto":"Diáspora hmong para os EUA e Europa após a Guerra do Vietnã."}
  ]'::jsonb,
  'asia', 35
),
(
  'Povos dravídicos e Adivasi',
  'dravidicos-adivasi',
  'Subcontinente indiano, sobretudo o centro e sul da Índia',
  'Presença anterior à chegada dos povos indo-arianos, c. 1500 a.C.',
  'Os povos Adivasi ("primeiros habitantes", em hindi) e as culturas de raiz dravídica representam algumas das tradições mais antigas do subcontinente indiano, com cosmologias próprias centradas em espíritos da floresta que antecedem — e influenciaram — o hinduísmo posterior.',
  '[
    {"ano":"Antes de c. 1500 a.C.","texto":"Presença de povos dravídicos e adivasi no subcontinente indiano, anterior à chegada indo-ariana."},
    {"ano":"Hoje","texto":"Mais de 700 grupos oficialmente reconhecidos como Adivasi na Índia contemporânea."}
  ]'::jsonb,
  'asia', 36
),
(
  'Mongóis e o tengrismo',
  'mongois-tengrismo',
  'Estepes da Mongólia e Ásia Central',
  'Império Mongol, 1206–1368',
  'O tengrismo, a tradição espiritual pré-budista dos povos mongóis e turcos da Ásia Central, centra-se no culto ao Céu Eterno (Tengri) e a espíritos da natureza — Genghis Khan é descrito nas fontes históricas como tendo governado com legitimidade atribuída ao Tengri.',
  '[
    {"ano":"1206","texto":"Genghis Khan é proclamado líder supremo, iniciando o Império Mongol."},
    {"ano":"Séc. XVI–XVII","texto":"Conversão progressiva dos mongóis ao budismo tibetano."},
    {"ano":"Hoje","texto":"Revitalização de práticas tengristas e xamânicas na Mongólia pós-socialista."}
  ]'::jsonb,
  'asia', 37
),
(
  'Aborígenes australianos',
  'aborigenes-australianos',
  'Austrália',
  'Ocupação contínua há pelo menos 65.000 anos',
  'Os povos aborígenes australianos mantêm uma das tradições espirituais vivas mais antigas do planeta, centrada no Tempo do Sonho (Dreamtime) — uma cosmologia que explica a criação do mundo e organiza a relação de cada pessoa com a terra através de centenas de nações e línguas distintas.',
  '[
    {"ano":"c. 65.000 anos atrás","texto":"Chegada dos primeiros povos aborígenes à Austrália, uma das migrações humanas mais antigas fora da África."},
    {"ano":"1788","texto":"Início da colonização britânica, com impacto devastador sobre as populações aborígenes."},
    {"ano":"2008","texto":"Pedido oficial de desculpas do governo australiano às Gerações Roubadas."}
  ]'::jsonb,
  'oceania', 38
),
(
  'Māori',
  'maori',
  'Aotearoa (Nova Zelândia)',
  'Chegada por volta de 1250–1300 d.C.',
  'Os Māori chegaram à Nova Zelândia em grandes canoas de navegação (waka) vindas da Polinésia oriental, trazendo uma cosmologia baseada em atua (deuses ancestrais) e no conceito de mana, a força espiritual presente em pessoas, lugares e objetos.',
  '[
    {"ano":"c. 1250–1300 d.C.","texto":"Chegada dos primeiros povos polinésios à Nova Zelândia em waka (canoas)."},
    {"ano":"1840","texto":"Tratado de Waitangi entre a Coroa britânica e chefes māori."},
    {"ano":"Hoje","texto":"Revitalização ativa da língua e cultura māori na Nova Zelândia."}
  ]'::jsonb,
  'oceania', 39
),
(
  'Povos polinésios',
  'polinesios',
  'Triângulo polinésio — Havaí, Taiti, Samoa, Ilha de Páscoa e outras',
  'Grande expansão de navegação entre c. 1000 a.C. e 1200 d.C.',
  'Os povos polinésios realizaram uma das maiores façanhas de navegação da história humana, cruzando milhares de quilômetros de oceano aberto guiados pelas estrelas, correntes e o voo de aves — parte da expansão austronésia que também alcançou Madagascar, do outro lado do Índico.',
  '[
    {"ano":"c. 1000 a.C.–1200 d.C.","texto":"Expansão polinésia por todo o Triângulo Polinésio, do Havaí à Ilha de Páscoa e Nova Zelândia."},
    {"ano":"Séc. XVIII","texto":"Primeiros contatos europeus documentados com ilhas polinésias."},
    {"ano":"Hoje","texto":"Revitalização das técnicas de navegação tradicional polinésia."}
  ]'::jsonb,
  'oceania', 40
)
on conflict (slug) do nothing;

-- 5) Rotas de migração/transmissão entre continentes
insert into public.culturas_migracoes (nome, continente_origem, continente_destino, descricao, ordem) values
('Diáspora transatlântica', 'africa', 'america-central-caribe', 'Tráfico transatlântico de pessoas escravizadas, levando tradições iorubás, bantas e jejes ao Caribe entre os séc. XVI e XIX.', 1),
('Diáspora transatlântica (Brasil)', 'africa', 'america-sul', 'Tráfico transatlântico de pessoas escravizadas para o Brasil, formando as bases do Candomblé, da Umbanda e da Quimbanda.', 2),
('Migração pela Beríngia', 'siberia', 'america-norte', 'Migração humana pré-histórica da Sibéria à América do Norte através da ponte de terra de Beríngia, entre 15.000 e 20.000 anos atrás.', 3),
('Expansão austronésia', 'asia', 'oceania', 'Expansão de povos austronésios do Sudeste Asiático pelo Oceano Pacífico, povoando a Polinésia e a Nova Zelândia entre 1000 a.C. e 1300 d.C.', 4),
('Rota da Seda', 'europa', 'asia', 'Rede de rotas comerciais e culturais que conectou Europa e Ásia por séculos, trocando não só mercadorias como religiões, filosofias e tecnologias.', 5)
on conflict do nothing;
