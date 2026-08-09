-- ==========================================================
-- Culturas afro-diaspóricas e indígenas — pacote adicional completo
-- Roda depois de supabase-culturas-schema.sql (precisa da tabela
-- "culturas" já criada). Usa "on conflict do nothing", então é
-- seguro rodar mesmo que algumas dessas já existam (ex: se você já
-- rodou uma versão anterior deste arquivo com Haiti/Trinidad/Suriname).
-- ==========================================================

insert into public.culturas (nome, slug, regiao_origem, periodo, resumo, marcos, ordem) values

(
  'Vodou haitiano',
  'haiti',
  'Haiti, a partir de povos jeje (fon), congo e iorubás escravizados',
  'Consolidado no séc. XVIII, decisivo na Revolução Haitiana (1791–1804)',
  'No Haiti, as tradições fon (jeje), congo e iorubá trazidas por pessoas escravizadas se fundiram no Vodou — palavra fon que significa "espírito". Diferente do Jeje brasileiro, o Vodou haitiano nasceu em condição de revolta: a cerimônia de Bois Caïman, em 1791, é apontada pela tradição oral como o estopim da Revolução Haitiana, que resultou no Haiti se tornando a primeira nação livre da escravidão nas Américas.',
  '[
    {"ano":"Séc. XVIII","texto":"Chegada de povos fon, congo e iorubás à colônia francesa de Saint-Domingue (atual Haiti)."},
    {"ano":"1791","texto":"Cerimônia de Bois Caïman, associada pela tradição oral ao início da revolta que se tornou a Revolução Haitiana."},
    {"ano":"1804","texto":"Independência do Haiti — primeira nação americana a abolir a escravidão."},
    {"ano":"Hoje","texto":"O Vodou segue como religião viva no Haiti e na diáspora haitiana pelo mundo."}
  ]'::jsonb,
  6
),
(
  'Orisha (Trinidad e Tobago)',
  'trinidad',
  'Trinidad e Tobago, a partir de povos iorubás escravizados',
  'Consolidada no séc. XIX, sob repressão colonial britânica',
  'Em Trinidad, o culto iorubá aos orixás (localmente chamado Orisha, antigamente "Shango") sobreviveu se misturando ao Spiritual Baptist e a elementos do catolicismo e do hinduísmo local. É outro ramo direto da mesma raiz iorubá que gerou o Candomblé Nagô e a Santería cubana.',
  '[
    {"ano":"Séc. XIX","texto":"Chegada de povos iorubás a Trinidad, incluindo levas trazidas já como trabalhadores contratados após a abolição britânica de 1834."},
    {"ano":"Séc. XX","texto":"Reconhecimento legal gradual do Orisha como religião em Trinidad e Tobago."}
  ]'::jsonb,
  7
),
(
  'Winti (Suriname)',
  'suriname',
  'Suriname, a partir de múltiplos povos da África Ocidental e Central',
  'Formado do séc. XVII ao XIX, sob colonização holandesa',
  'No Suriname, o Winti reúne espíritos de diferentes povos africanos — akan, congo, iorubá e outros — trazidos pela colonização holandesa. É especialmente marcante entre os maroons (quilombolas surinameses), descendentes de pessoas escravizadas que fugiram e formaram comunidades livres na floresta, preservando tradições africanas com menos mistura europeia do que em outras partes das Américas.',
  '[
    {"ano":"Séc. XVII–XVIII","texto":"Tráfico de pessoas escravizadas de diferentes regiões da África Ocidental e Central para o Suriname holandês."},
    {"ano":"Séc. XVIII","texto":"Formação de comunidades maroons (como os Saramaka e Ndyuka) que preservam tradições africanas na floresta."},
    {"ano":"1971","texto":"Fim formal da proibição colonial ao Winti no Suriname."}
  ]'::jsonb,
  8
),
(
  'Palo Monte / Palo Mayombe',
  'palo-monte',
  'Cuba, a partir de povos bakongo (Congo e Angola)',
  'Consolidado a partir do séc. XIX',
  'De raiz bakongo, o Palo Monte cultua os mpungos — forças da natureza — e centra sua liturgia na nganga, o caldeirão sagrado que guarda os fundamentos da casa. É o ramo cubano mais próximo do Candomblé de Angola brasileiro, por vir da mesma matriz banto, e costuma ser praticado lado a lado com a Santería (de raiz iorubá) nas mesmas famílias religiosas cubanas.',
  '[
    {"ano":"Séc. XVI–XIX","texto":"Chegada de povos bakongo a Cuba ao longo de todo o período do tráfico transatlântico."},
    {"ano":"Séc. XIX","texto":"Formação dos primeiros munansos (casas) de Palo em Cuba."},
    {"ano":"Hoje","texto":"Praticado com frequência em conjunto com a Santería, em iniciações complementares."}
  ]'::jsonb,
  9
),
(
  'Kumina',
  'kumina',
  'Jamaica (sobretudo a paróquia de St. Thomas), a partir de povos congo',
  'Consolidada no séc. XIX',
  'O Kumina é uma tradição jamaicana de possessão e percussão, de raiz congo, mantida viva sobretudo por descendentes de africanos que chegaram à Jamaica já após a abolição britânica, como trabalhadores contratados. Preserva até hoje cantos em kikongo e um culto direto aos ancestrais, com menos sincretismo cristão do que outras tradições da diáspora caribenha.',
  '[
    {"ano":"1841–1865","texto":"Chegada à Jamaica de africanos congo contratados como trabalhadores livres após o fim da escravidão britânica (1838)."},
    {"ano":"Séc. XIX–XX","texto":"Consolidação do Kumina na paróquia de St. Thomas, com cantos e ritmos kikongo preservados por gerações."}
  ]'::jsonb,
  10
),
(
  'Jurema Sagrada / Catimbó',
  'jurema',
  'Nordeste do Brasil — povos indígenas (Potiguara, Tupi e outros), com camadas africanas e populares católicas',
  'Praticada desde antes da colonização; formalizada como catimbó nos séc. XIX–XX',
  'A Jurema é uma tradição brasileira de raiz indígena, centrada no uso ritual do chá feito da árvore sagrada jurema para entrar em contato com Mestres, Caboclos e Encantados. É uma das três grandes raízes da Umbanda — ao lado das tradições africanas e do espiritismo — e é especialmente forte nos terreiros do Nordeste, onde muitas vezes se funde com elementos afro-brasileiros.',
  '[
    {"ano":"Antes de 1500","texto":"Uso ritual da jurema por povos indígenas do Nordeste brasileiro, anterior à colonização."},
    {"ano":"Séc. XIX–XX","texto":"Perseguição da Jurema/catimbó pelo Estado e pela Igreja como \"feitiçaria\", forçando práticas à clandestinidade."},
    {"ano":"Séc. XX","texto":"Encontro da Jurema com a Umbanda em formação, e com tradições afro-brasileiras, dando origem a vertentes como a Umbanda Sagrada e o Omolokô."},
    {"ano":"Hoje","texto":"Crescente reconhecimento da Jurema como patrimônio cultural e religioso brasileiro."}
  ]'::jsonb,
  11
),
(
  'Quimbanda',
  'quimbanda',
  'Brasil, formada junto com a Umbanda a partir de raízes banto, iorubás e populares',
  'Consolidada em paralelo à Umbanda, a partir das décadas de 1920–1930',
  'A Quimbanda é uma tradição brasileira que tem os Exus e Pombagiras como guias centrais — entidades ligadas à noite, às encruzilhadas e à resolução direta dos problemas da vida material. Nasceu da mesma matriz histórica da Umbanda, no Rio de Janeiro do início do séc. XX, mas se organizou como caminho litúrgico e cosmológico próprio.',
  '[
    {"ano":"1920–1930","texto":"Formação da Quimbanda em paralelo à Umbanda nascente, no Rio de Janeiro."},
    {"ano":"Séc. XX","texto":"Consolidação de rituais e hierarquias próprias para o culto a Exu e Pombagira."}
  ]'::jsonb,
  12
),
(
  'Formação do Candomblé no Brasil',
  'formacao-candomble',
  'Salvador, Bahia',
  'A partir de c. 1830, organizado em nações ao longo do séc. XIX',
  'O Candomblé nasce na Bahia quando as tradições Nagô/Ketu (iorubá), Jeje (fon) e Angola (banto) — antes práticas de povos distintos — se reorganizam em solo brasileiro como religião estruturada em "nações", cada uma preservando sua própria língua ritual, panteão e liturgia. É a religião-irmã mais antiga da Umbanda: enquanto o Candomblé preserva os cultos africanos com poucas misturas, a Umbanda (surgida quase um século depois) funde essas mesmas raízes ao espiritismo e à Jurema indígena.',
  '[
    {"ano":"c. 1830","texto":"Fundação do Ilê Axé Iyá Nassô Oká (Terreiro da Casa Branca), em Salvador — considerado o primeiro terreiro de Candomblé Nagô/Ketu organizado no Brasil."},
    {"ano":"Séc. XIX","texto":"Organização paralela das nações Jeje e Angola, cada uma com seus próprios terreiros e liturgia."},
    {"ano":"1889–1937","texto":"Perseguição policial sistemática aos terreiros de Candomblé durante a Primeira República e o Estado Novo."},
    {"ano":"Hoje","texto":"O Candomblé segue vivo na Bahia e em todo o Brasil, reconhecido como patrimônio cultural."}
  ]'::jsonb,
  13
),
(
  'Vodou de Nova Orleans',
  'louisiana',
  'Louisiana (EUA), a partir de povos congo, fon e outros da África Ocidental',
  'Consolidado do séc. XVIII ao XIX, sob domínio francês e depois espanhol',
  'Formado sob lógica parecida à do Vodou haitiano — aliás reforçado pela chegada de refugiados haitianos após 1791 —, o Vodou de Nova Orleans se distingue por ter incorporado mais elementos do catolicismo franco-espanhol e por ter sido, por décadas, publicamente liderado por mulheres, como a célebre Marie Laveau no séc. XIX.',
  '[
    {"ano":"Séc. XVIII","texto":"Chegada de povos africanos escravizados à Louisiana francesa, sobretudo de origem congo e fon."},
    {"ano":"Pós-1791","texto":"Chegada de refugiados da Revolução Haitiana, reforçando e transformando o Vodou local."},
    {"ano":"Séc. XIX","texto":"Ascensão de Marie Laveau como liderança pública do Vodou em Nova Orleans."}
  ]'::jsonb,
  14
),
(
  'Garifuna',
  'garifuna',
  'Caribe (São Vicente) e depois América Central — Honduras, Belize, Guatemala',
  'Formado no séc. XVII–XVIII, deportado para a América Central em 1797',
  'Os garifunas nasceram do encontro entre povos caribes/arawak da ilha de São Vicente e africanos náufragos ou fugidos de navios negreiros — um povo afro-indígena, não puramente africano. Sua tradição central é o Dügü, uma cerimônia de vários dias para honrar e apaziguar os ancestrais, conduzida por um buyei (líder espiritual).',
  '[
    {"ano":"Séc. XVII","texto":"Encontro entre povos caribes de São Vicente e africanos náufragos, formando o povo garifuna."},
    {"ano":"1797","texto":"Deportação em massa dos garifunas pelos britânicos para a costa da América Central."},
    {"ano":"Hoje","texto":"Comunidades garifunas em Honduras, Belize, Guatemala e Nicarágua preservam língua, música e o ritual do Dügü."}
  ]'::jsonb,
  15
),
(
  'Lumbalú (Palenque de San Basilio)',
  'lumbalu',
  'Palenque de San Basilio, Colômbia — a partir de povos bakongo',
  'Formado a partir do séc. XVII, num dos primeiros quilombos livres das Américas',
  'O Palenque de San Basilio, fundado por pessoas escravizadas fugidas na Colômbia, é um dos primeiros povoados livres reconhecidos das Américas. Sua tradição fúnebre, o Lumbalú, usa tambores e cantos em palenquero (crioulo de base kikongo) para acompanhar o luto e guiar o falecido aos ancestrais — uma das heranças bakongo mais diretamente preservadas fora da África.',
  '[
    {"ano":"Séc. XVII","texto":"Fundação do Palenque de San Basilio por africanos fugidos da escravidão, liderados por Benkos Biohó."},
    {"ano":"1713","texto":"Reconhecimento formal da liberdade do palenque pela Coroa espanhola — um dos primeiros da história americana."},
    {"ano":"Hoje","texto":"O Lumbalú e a língua palenquera seguem vivos, reconhecidos pela UNESCO como patrimônio da humanidade."}
  ]'::jsonb,
  16
),
(
  'Povos indígenas do Brasil e a linha de Caboclo',
  'indigena-brasil',
  'Brasil — sobretudo povos Tupi-Guarani, além de outros troncos indígenas',
  'Presença anterior à colonização, incorporada à Umbanda a partir de 1908',
  'Além da Jurema (mais concentrada no Nordeste), a linha de Caboclo na Umbanda bebe de uma imagística indígena brasileira mais ampla — sobretudo tupi-guarani —, com guias que se apresentam como caciques, índias e curadores da mata. É a terceira grande raiz da Umbanda, ao lado das tradições africanas e do espiritismo, e reflete a tentativa do Brasil do início do séc. XX de reconhecer também uma ancestralidade indígena nos guias espirituais nacionais.',
  '[
    {"ano":"Antes de 1500","texto":"Cosmologias e práticas de cura de diversos povos indígenas no território hoje brasileiro."},
    {"ano":"1908 em diante","texto":"Incorporação da figura do Caboclo como guia central na Umbanda em formação no Rio de Janeiro."},
    {"ano":"Séc. XX","texto":"Consolidação de linhas e falanges de Caboclo (das matas, das cachoeiras, das pedreiras) na liturgia umbandista."}
  ]'::jsonb,
  17
)
on conflict (slug) do nothing;
