% LOGICA PARA COMPUTACAO - TRABALHO PROLOG
% Exercicios 10.1 a 10.16
% Prof.: Henrique 
% Aluno: Lucas Mendes B. dos Santos


:- discontiguous genitor/2.
:- discontiguous mulher/1.
:- discontiguous homem/1.
:- discontiguous animal/1.
:- discontiguous planta/1.
:- discontiguous come/2.
:- discontiguous presa/1.
:- discontiguous herbivoro/1.
:- discontiguous carnivoro/1.
:- discontiguous passaro/1.
:- discontiguous peixe/1.
:- discontiguous mamifero/1.


% PROGRAMA BASE - Exercicios 10.1 a 10.4


% --- Fatos: Relacoes de genitores ---
genitor(pam, bob).
genitor(tom, bob).
genitor(tom, liz).
genitor(bob, ann).
genitor(bob, pat).
genitor(pat, jim).

% --- Fatos: Genero ---
mulher(pam).
mulher(liz).
mulher(pat).
mulher(ann).

homem(tom).
homem(bob).
homem(jim).

% --- Regras do programa base ---
prole(Y, X) :- genitor(X, Y).

mae(X, Y) :- genitor(X, Y), mulher(X).

avos(X, Z) :- genitor(X, Y), genitor(Y, Z).

irma(X, Y) :-
    genitor(Z, X),
    genitor(Z, Y),
    mulher(X),
    \+(X = Y).

descendente(X, Z) :- genitor(X, Z).
descendente(X, Z) :- genitor(X, Y), descendente(Y, Z).


% EXERCICIO 10.3: Novas regras para o programa familiar


% 10.3.2 - Irmao (sexo masculino)
irmao(X, Y) :-
    genitor(Z, X),
    genitor(Z, Y),
    homem(X),
    \+(X = Y).

% 10.3.1 - Tio e Tia
tio(X, Z) :- genitor(Y, Z), irmao(X, Y).
tia(X, Z) :- genitor(Y, Z), irma(X, Y).

% 10.3.3 - Avos paternos (do lado do pai)
avos_paternos(X, Z) :-
    genitor(Pai, Z),
    homem(Pai),
    genitor(X, Pai).

% 10.3.4 - Avos maternos (do lado da mae)
avos_maternos(X, Z) :-
    genitor(Mae, Z),
    mulher(Mae),
    genitor(X, Mae).

% 10.3.5 - Ascendente (inverso de descendente)
% ascendente(X, Z): Z e um ancestral (ascendente) de X
ascendente(X, Z) :- genitor(Z, X).
ascendente(X, Z) :- genitor(Y, X), ascendente(Y, Z).

% 10.3.6 - Primo / Prima
% Novos fatos adicionados para possibilitar consultas sobre primos:
genitor(liz, carol).
genitor(liz, mike).
mulher(carol).
homem(mike).

primo(X, Y) :-
    genitor(PA, X),
    genitor(PB, Y),
    \+(PA = PB),
    \+(X = Y),
    once((irmao(PA, PB) ; irma(PA, PB) ; irmao(PB, PA) ; irma(PB, PA))).


% EXERCICIO 10.5: Base de conhecimento animal


% --- Individuos e suas especies ---
canario(piupiu).
avestruz(xica).
tubarao(tutu).
salmao(alfred).
vaca(mimosa).
morcego(vamp).

% --- Hierarquia de tipos ---
passaro(X) :- canario(X).
passaro(X) :- avestruz(X).
peixe(X)   :- tubarao(X).
peixe(X)   :- salmao(X).
peixe(nemo).
mamifero(X) :- vaca(X).
mamifero(X) :- morcego(X).

animal(X) :- passaro(X).
animal(X) :- peixe(X).
animal(X) :- mamifero(X).

% --- Cor ---
cor(X, amarelo) :- canario(X).

% --- Excecoes ao comportamento padrao ---
nao_voa(X)      :- avestruz(X).
nao_poe_ovos(X) :- tubarao(X).

% --- Regras gerais ---
tem_pele(X)     :- animal(X).
tem_nadadeira(X):- peixe(X).
pode_nadar(X)   :- peixe(X).
tem_asas(X)     :- passaro(X).
tem_asas(X)     :- morcego(X).
pode_voar(X)    :- passaro(X), \+(nao_voa(X)).
pode_voar(X)    :- morcego(X).
poe_ovos(X)     :- passaro(X).
poe_ovos(X)     :- peixe(X), \+(nao_poe_ovos(X)).
anda(X)         :- mamifero(X), \+(pode_voar(X)).
anda(X)         :- avestruz(X).
comestivel(X)   :- vaca(X).
comestivel(X)   :- salmao(X).

% PROGRAMA BASE - Exercicios 10.6 a 10.8


animal(urso).
animal(peixe).
animal(peixinho).
animal(guaxinim).
animal(raposa).
animal(coelho).
animal(veado).
animal(lince).

planta(alga).
planta(grama).

come(urso,     peixe).
come(peixe,    peixinho).
come(peixinho, alga).
come(guaxinim, peixe).
come(urso,     guaxinim).
come(urso,     raposa).
come(raposa,   coelho).
come(coelho,   grama).
come(urso,     veado).
come(veado,    grama).
come(lince,    veado).

presa(X) :- come(_, X), animal(X).


% EXERCICIO 10.7: Herbivoro e Carnivoro


herbivoro(X) :- animal(X), once((come(X, Y), planta(Y))).
carnivoro(X) :- animal(X), once((come(X, Y), animal(Y))).


% EXERCICIO 10.9: Capitais dos estados brasileiros


capital(acre,             rio_branco).
capital(alagoas,          maceio).
capital(amapa,            macapa).
capital(amazonas,         manaus).
capital(bahia,            salvador).
capital(ceara,            fortaleza).
capital(distrito_federal, brasilia).
capital(espirito_santo,   vitoria).
capital(goias,            goiania).
capital(maranhao,         sao_luis).
capital(mato_grosso,      cuiaba).
capital(mato_grosso_sul,  campo_grande).
capital(minas_gerais,     belo_horizonte).
capital(para,             belem).
capital(paraiba,          joao_pessoa).
capital(parana,           curitiba).
capital(pernambuco,       recife).
capital(piaui,            teresina).
capital(rio_de_janeiro,   rio_de_janeiro).
capital(rio_grande_norte, natal).
capital(rio_grande_sul,   porto_alegre).
capital(rondonia,         porto_velho).
capital(roraima,          boa_vista).
capital(santa_catarina,   florianopolis).
capital(sao_paulo,        sao_paulo).
capital(sergipe,          aracaju).
capital(tocantins,        palmas).

capital_do_estado(Estado, Capital) :- capital(Estado, Capital).

% EXERCICIO 10.10: Compatibilidade de tipos sanguineos


% pode_doar(+Doador, +Receptor)
pode_doar(o,  o).
pode_doar(o,  a).
pode_doar(o,  b).
pode_doar(o,  ab).
pode_doar(a,  a).
pode_doar(a,  ab).
pode_doar(b,  b).
pode_doar(b,  ab).
pode_doar(ab, ab).

% pode_receber(+Receptor, -Doador)
pode_receber(Receptor, Doador) :- pode_doar(Doador, Receptor).


% EXERCICIO 10.11: Predicados sobre listas


% 10.11.1 - Intersecao de duas listas
intersecao([], _, []).
intersecao([H|T], L2, [H|I]) :-
    member(H, L2), !,
    intersecao(T, L2, I).
intersecao([_|T], L2, I) :-
    intersecao(T, L2, I).

% 10.11.2 - Verifica se um conjunto esta contido em uma lista
subconjunto([], _).
subconjunto([H|T], L) :-
    member(H, L),
    subconjunto(T, L).

% 10.11.3 - Verifica se lista tem tamanho par ou impar
tamanho_par([]).
tamanho_par([_,_|T]) :- tamanho_par(T).

tamanho_impar([_]).
tamanho_impar([_,_|T]) :- tamanho_impar(T).

% 10.11.4 - Inverter lista usando concatenacao (append)
inverter([], []).
inverter([H|T], R) :-
    inverter(T, TI),
    append(TI, [H], R).

% 10.11.5 - Maior valor em lista numerica
maximo([X], X).
maximo([H|T], M) :-
    maximo(T, M1),
    M is max(H, M1).

% 10.11.6 - Soma dos N primeiros numeros naturais (0+1+2+...+N)
soma_naturais(0, 0) :- !.
soma_naturais(N, S) :-
    N > 0,
    N1 is N - 1,
    soma_naturais(N1, S1),
    S is S1 + N.


% EXERCICIO 10.12: N-esima potencia de um numero


% potencia(+Base, +Expoente, -Resultado)
potencia(_, 0, 1) :- !.
potencia(Base, Exp, Result) :-
    Exp > 0,
    Exp1 is Exp - 1,
    potencia(Base, Exp1, R1),
    Result is Base * R1.


% EXERCICIO 10.13: Checagem eficiente com cortes

% Versao eficiente usando corte (evita tentar clausulas desnecessarias):
checagem(N, positivo) :- N > 0, !.
checagem(0, zero)     :- !.
checagem(_, negativo).


% EXERCICIO 10.14: Classificacao por faixa etaria com cortes


classificar(Idade, crianca)     :- Idade =< 12, !.
classificar(Idade, adolescente) :- Idade =< 18, !.
classificar(Idade, adulto)      :- Idade =< 65, !.
classificar(_, idoso).


% EXERCICIO 10.15: Signo zodiacal com cortes


% signo(+Dia, +Mes, -Signo)
signo(D,  12, capricornio) :- D >= 22, !.
signo(D,   1, capricornio) :- D =< 19, !.
signo(D,   1, aquario)     :- D >= 20, !.
signo(D,   2, aquario)     :- D =< 18, !.
signo(D,   2, peixes)      :- D >= 19, !.
signo(D,   3, peixes)      :- D =< 20, !.
signo(D,   3, aries)       :- D >= 21, !.
signo(D,   4, aries)       :- D =< 19, !.
signo(D,   4, touro)       :- D >= 20, !.
signo(D,   5, touro)       :- D =< 20, !.
signo(D,   5, gemeos)      :- D >= 21, !.
signo(D,   6, gemeos)      :- D =< 20, !.
signo(D,   6, cancer)      :- D >= 21, !.
signo(D,   7, cancer)      :- D =< 22, !.
signo(D,   7, leao)        :- D >= 23, !.
signo(D,   8, leao)        :- D =< 22, !.
signo(D,   8, virgem)      :- D >= 23, !.
signo(D,   9, virgem)      :- D =< 22, !.
signo(D,   9, libra)       :- D >= 23, !.
signo(D,  10, libra)       :- D =< 22, !.
signo(D,  10, escorpiao)   :- D >= 23, !.
signo(D,  11, escorpiao)   :- D =< 21, !.
signo(D,  11, sagitario)   :- D >= 22, !.
signo(_,  12, sagitario).


% EXERCICIO 10.16: Traducao de codigos de erro (versao declarativa)


% Versao original (procedimental - menos descritiva):
%   traduza(Codigo, Sig) :- Codigo=1, Sig=integer_overflow.
%   traduza(Codigo, Sig) :- Codigo=2, Sig=divisao_por_zero.
%   traduza(Codigo, Sig) :- Codigo=3, Sig=id_desconhecido.

% Versao melhorada (declarativa - usando fatos diretos):
traduza(1, integer_overflow).
traduza(2, divisao_por_zero).
traduza(3, id_desconhecido).
