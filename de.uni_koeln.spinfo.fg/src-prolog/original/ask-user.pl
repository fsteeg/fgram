% Author:
% Date: 06.03.03

/* Dialogkomponenten*/
choose_pred(Word,Kind,Class,Forms,Args,Satellites) :-
   choose(Kind,Predlist),
   write_nl('Choose a predicate from following list:'),
   printlist(Predlist),
   read(Word),
   PROGRAM=..[Kind,Word,Class,Fs,Args,Satellites], call(PROGRAM),
%   get(Kind,Word,Class,Fs,Args,Satellites),
   /* Wird nur f�r noun ben�tigt, siehe zwei Pr�dikate weiter */
   forms(Kind,Fs,Forms),
   write('Forms: '),write(Forms),nl.

choose(Kind,Predlist) :-
   write_nl('What kind of predicate do you want?'),
   write_nl('verb, noun or adj(ective)?'),
   read(Kind),
   suffix(Kind,list,Klist),
  PROGRAM=..[Klist,Predlist], call(PROGRAM).

forms(noun,Fs,[noun,noun]).
forms(Kind,Forms,Forms).

askof(of_noun,Noun,no).
askof(Kind,Noun,Of) :-
   write('Do you want an of_phrase for '),
   printquote(Noun),
   write_nl('? yes or no?'),
   read(Of).

askrel(Noun,Rel) :-
   write('Do you want a relative clause for '),
   printquote(Noun),
   write_nl('? yes or no?'),
   read(Rel).

/* role_for_relnoun wird aus form_predication aufgerufen. Falls
   Hauptsatz, dann das erste Pr�dikat, sonst das zweite Pr�dikat. */
role_for_relnoun(W,Args,Args,[],[[],[],[],[],[],[],[]],A,A) :- !.

role_for_relnoun(W,Args,Args1,Role,[rel,Termop,Relnoun,GramInfo,Modif,Rphr,[]],A,A) :-
   inf_argument_insertion(W,[[Role,infinitive,[rel,Termop,Relnoun,GramInfo,Modif,Rphr,[]]]|Tailargs],
                   Args,Args1,Nounlist,Alist,Alist2,Qrole,Qterm,Ill,Mode,R), !.
role_for_relnoun(W,Args,Args1,Role,[rel,Termop,Relnoun,GramInfo,Modif,Rphr,[]],A,A) :-
   choose_role(Relnoun,Args,Role),
   noun(Relnoun,Class,[Plural,Gender],[[R,Res,X]],Sat),
   write('Args in role for relnoun: '),write(Args),nl,
   member([Role,Restr,[rel,Termop,Relnoun,[Res,Plural,Gender],Modif,Rphr,[]]],Args),
   write('In role for relnoun. Role: '), write(Role),write('   Termop: '),write(Termop),nl,
   delete_arg(Role,Term,Args,Args1).

/*role_for_relnoun(W,Args,Args1,Role,[rel,Termop,Relnoun,GramInfo,Modif,Rphr,[]],A,A) :-
   inf_argument_insertion(W,[[Role,infinitive,[rel,Termop,Relnoun,GramInfo,Modif,Rphr,[]]]|Tailargs],
                   Args,Args1,Nounlist,Alist,Alist2,Qrole,Qterm,Ill,Mode,R);
   (choose_role(Relnoun,Args,Role),
   noun(Relnoun,Class,[Plural,Gender],[[R,Res,X]],Sat),
   write('Args in role for relnoun: '),write(Args),nl,
   member([Role,Restr,[rel,Termop,Relnoun,[Res,Plural,Gender],Modif,Rphr,[]]],Args),
   write('In role for relnoun. Role: '), write(Role),write('   Termop: '),write(Termop),nl,
   delete_arg(Role,Term,Args,Args1)
                                      ).*/
                                      
/* Die folgenden beiden Pr�dikate (jeweils 8 und 4 Argumente) auskommentiert, da sie anscheinend nicht
   aufgerufen werden. Nur obiges Pr�dikat scheint ben�tigt zu werden. 1.12.03 */
/*role_for_relnoun(Adj,Th,[[R,infinitive,Infinitive]],[[R,infinitive,Infinitive]],Role,Term,Alist,Alist) :-
   !.
% fragwuerdig : 8 Argumente, zweimal Infinitive, wegen Theme ?
role_for_relnoun(W,[],[],[Role,Restr,[rel,Termop,Relnoun,GramInfo,Modif,Rphr,[]]]).*/

choose_role(Noun,[[argument,infinitive,Term]],Role) :- !. /* wegen easy */
choose_role(Noun,[[Role,Restriction,Term]],Role) :- !.
choose_role(Noun,[[Role,R,T],[goal,proposition,T]],Role) :- !.
choose_role(Noun,Args,Role) :-
   write('Choose a role for '),
   printquote(Noun),
   write_nl(' in the relative clause from following:'),
   writeroles(Args),
   read(Role).

/* Wurde ein Eigenname als Argument eingegeben, wird nach +/-human
   und - wenn bejaht - nach Genus gefragt. */
properNoun(ProperNoun,[SemRestr,sing,Gender],Alist,Alist1) :-
   write('Is '),
   write(ProperNoun),
   write_nl(' human? yes or no?'),
   read(Answer),
   check(Answer,human,X,SemRestr),
   write_nl('Is gender masc,fem or neuter?'),
   read(Gender),
   add_member([[[],sing],ProperNoun,[SemRestr,P,Gender],[]],Alist,Alist1).

/* Nachfrage im Falle von Fragen, ob ein Interrogativ Neutrum oder Mask./Fem.
   gew�hlt werden soll. */
ask_gender(Role,human,Gender) :-
   eq(Gender,human).
ask_gender(Role,Restriction,Gender) :-
   write('Is '),
   write(Role),
   write_nl(' human? yes or no?'),
   read(Answer),
   check(Answer,human,neuter,Gender).

number(_,Number):-
   write_nl('Is number sing or plural?'),
   read(Number).
/* Wurden auskommentiert und durch obiges Pr�dikat ersetzt. 1.12.03 */
/*number(noun,Number):-
   write_nl('Is number sing or plural?'),
   read(Number).
number(argument,Number) :-
   write_nl('Is number sing or plural?'),
   read(Number).
number(of_noun,Number) :-
   write_nl('Is number sing or plural?'),
   read(Number).*/

ask_for_modifier(Noun,A,Answer) :-
   write('Do you want '),
   write(A),
   write(' adjectival restrictor for '),
   printquote(Noun),
   write_nl('? yes or no?'),
   read(Answer).

insert_modifier(Noun,Modif,Modif,A,no).
insert_modifier(Noun,Modif,Modif2,Adjlist,yes) :-
   write_nl('Choose adjective from following list:'),
   printlist(Adjlist),
   read(Adj),
   add_member(Adj,Modif,Modif1),
   ask_for_modifier(Noun,another,Answer),
   insert_modifier(Noun,Modif1,Modif2,Adjlist,Answer).

of(Noun,Nlist,[],Alist,Alist,no).
of(Noun,Nlist,Ofphrase,Alist,Alist1,yes) :-
   write('Which term do you want as of_phrase in relation to '),
   printquote(Noun),
   questionmark,
   write_nl('Choose from the following list, enter a proper noun, ask "wh"'),
   printlist(Nlist),
   read(Noun1),
   check_term(of_noun,Noun1,Role,Restriction,Ofphrase,Args,
   Nlist,Alist,Alist1,Q,Qt,I).


ask_for_raising(noun, [Class,Voice,[ind,present,non_perfect,non_progressive,Num],[Word,Forms],
   [[],Subject,[], Inf,[]]],
   Raising) :-
   write('Do you want to raise '),
   printquote(Word),
   write_nl('? yes or no?'),
   read(Raising).
ask_for_raising(Kind,Relclause,no).

ask_for_raising(no,want,Predication,no,Clause) :-
     write('Predication: '),write(Predication),nl.
ask_for_raising(yes,want,Predication,yes,Clause).

ask_for_raising(no,Predicate,Predication,no,Clause).

ask_for_raising(R,eager,Predication,no,Clause).


ask_for_raising(yes,Word,[Class,Voice,[ind,Tense,Pf,Pg,Num],[V,Vf],
   [T,[],[],Restargs,Sat]],no,Clause).

ask_for_raising(yes,Word,[Class,Voice,[ind,Tense,Pf,Pg,Num],[V,Vf],
   [rel,T,Noun,G,M,Rp,R,Restargs,Sat]],yes,relclause).

/* "unexpressed" darf nicht geraised werden */
ask_for_raising(yes,Word,[Class,Voice,[ind,Tense,Pf,Pg,Num],[V,Vf],
   [[P,T,unexpressed,G,M,Rp,R],Restargs,Sat]],no,Clause).
ask_for_raising(yes,Word,[Class,Voice,[ind,Tense,Pf,Pg,Num],[V,Vf],
   [T,[P,Op,unexpressed,G,M,Rp,R],Object,Restargs,Sat]],no,Clause).

ask_for_raising(yes,Word,[Class,Voice,[ind,Tense,Pf,Pg,Num],[V,Vf],
   [[P,T,Noun,G,M,Rp,R],Restargs,Sat]],Raising,Clause) :-
   write('Do you want to raise '),
   printquote(Noun),
   write_nl('? yes or no?'),
   read(Raising).
ask_for_raising(yes,Word,[Class,Voice,[ind,Tense,Pf,Pg,Num],[V,Vf],
   [T,[P,Op,Noun,G,M,Rp,R],Object,Restargs,Sat]],Raising,Clause) :-
   write('Do you want to raise '),
   printquote(Noun),
   write_nl('? yes or no?'),
   read(Raising).

ask_for_raising(yes,easy,[Class,Voice,[ind,Tense,Pf,Pg,Num],[V,Vf],
   [[],Restargs,Sat]],yes,relclause).

ask_for_raising(yes,Word,[Class,Voice,[ind,Tense,Pf,Pg,Num],[V,Vf],
   [[],Restargs,Sat]],Raising,Clause) :-
   write('Do you want to raise '),
   printquote(V),
   write_nl('? yes or no?'),
   read(Raising).

ask_for_raising(yes,Word,[Class,Voice,[ind,Tense,Pf,Pg,Num],[V,Vf],
   [[P,T,Noun,G,M,Rp,R],Restargs,Sat]],Raising,Clause,inf) :-
   write('Do you want to raise the infinitive phrase'),
   write_nl('? yes or no?'),
   read(Raising).


ask_for_satellites(have,A,no).
ask_for_satellites(Word,A,Answer) :-
   write('Do you want '),
   write(A),
   write(' satellite for '),
   printquote(Word),
   write_nl('? yes or no?'),
   read(Answer).


askterm(want,goal,proposition,Args,Predication,Nlist,Alist,Alist1,Q,Qt,I,M,R) :-
   write('Form predication that is '),
   write(goal),
   write(' of '),
   printquote(want),
   write_nl('!'),
   write_nl('Is the first argument of the proposition the same as the experiencer of "want" ?'),
   write_nl('Answer yes or no!'),
   read(Answer),
   set_R(Answer,R),
   write('Args: '),write(Args),nl,
   write('Pred: '),write(Predication),nl,
   firstarg_id(Answer,Args,Predication,Finiteness),!,
   write('Pred: '),write(Predication),nl,
   underlying(Predication,K,Alist,Alist1,want,Finiteness,R).

askterm(Verb,Role,proposition,Args,Predication,Nlist,Alist,Alist1,Q,Qt,I,M,yes) :-
   write('Form predication that is '),
   write(Role),
   write(' of '),
   printquote(Verb),
   write_nl('!'),
   underlying(Predication,K,Alist,Alist1,Verb,finite,R).

askterm(Adj,Role,infinitive,Args,Infinitive,Nlist,Alist,Alist1,Q,Qt, Illocution,M,yes) :-
   write('Form infinitive that is '),
   write(Role),
   write(' of '),
   printquote(Adj),
   write_nl('!'),
   underlying(Infinitive,Illocution,Alist,Alist1,adj,infinitive,R).

askterm(Word,Role,Restriction,Args,[P,T,N,G,M,Rp,R],Nlist,Alist,Alist1,Q,Qt,I,Mode,Raisability) :-
  write('Predication: '),write([P,T,N,G,M,Rp,R]),nl,
   var(N),!,
   write('Which term do you want as '),
   write(Role),
   write(' of '),
   printquote(Word),
   questionmark,
   write('Choose from the following list, enter a proper noun, ask "wh" '),
   write_nl(' or enter "unexpressed":'),
   printlist(Nlist),
   read(Noun),
   write('check_term in askterm'),nl,
   check_term(argument,Noun,Role,Restriction,[P,T,N,G,M,Rp,R],
   Args,Nlist,Alist,Alist1,Q,Qt,I).

askterm(Word,Role,Restriction,Args,[P,T,N,G,M,Rp,R],Nlist,Alist,Alist,Q,Qt,I,Mode,Raisability) :-
  write('Predication: '),write([P,T,N,G,M,Rp,R]),nl,
      write('Role: '),   write(Role),nl.

/* HAVE_UNTERDRUCKUNG f�r want ('Peter wants (to have) a book') */
check_have(have,InfPhrase,InfPhrase1) :-
   write_nl('Do you want to suppress "to have"? "expr" or "suppr"?'),
   read(Answer),
   PROGRAM=..[Answer,InfPhrase,InfPhrase1], call(PROGRAM).

check_have(Word,InfPhrase,InfPhrase).

inf_rel_askterm(Relnoun,Adj,Role,infinitive,Args,Infinitive,Nlist,Alist,Alist1,Q,Qt, Illocution,M,yes):-
   write('Form infinitive that is '),
   write(Role),
   write(' of '),
   printquote(Adj),
   write_nl('!'),
   inf_rel_underlying(Relnoun,Infinitive,Illocution,Alist,Alist1,adj,infinitive,R).

/* Hillfsprogramme f�r askterm want  */
set_R(yes,no).
set_R(no,yes).

firstarg_id(no,Args,Pred,finite).

/*firstarg_id(yes,[[Role,Restr,Term]|Restargs],[S,V,T,Wf,[I|R]],infinitive).*/
firstarg_id(yes,[[Role,Restr,Term]|Restargs],Predication,infinitive).

/* Neu eingef�gt: Erweiterung f�r passivische Infinitive ( ... is eager to be Ved ...) */
/*askterm(Word,Role,Restriction,Args,[P,T,N,G,M,Rp,R],Nlist,Alist,Alist1,Q,Qt,I,infinitive,Raisability) :-
  write('Predication: '),write([P,T,N,G,M,Rp,R]),nl,
   var(N),!,
   write('Is the Goal of '),
   write(Word),
   write(' the same as the Agent of the matrix verb?'),
   nl,
   write_nl('Answer yes or no!'),
   read(Answer),
   ( ( eq(Answer, no),
       write('Which term do you want as '),
       write(Role),
       write(' of '),
       printquote(Word),
       questionmark,
       write('Choose from the following list, enter a proper noun, ask "wh" '),
       write_nl(' or enter "unexpressed":'),
       printlist(Nlist),
       read(Noun),
       write('check_term in askterm'),nl
     );
       eq(Noun, unexpressed)
   ),
   check_term(argument,Noun,Role,Restriction,[P,T,N,G,M,Rp,R],
   Args,Nlist,Alist,Alist1,Q,Qt,I). */

/* ============================================================== */

/* TEMPUS_ASPEKT_MODUS */

modality(ind,Word,want) :- !.

modality(Mod,Word,Headverb) :-
   write('Which modality do  you want for '),
   printquote(Word),
   questionmark,
   write('future,possibility,potentiality,necessity or '),
   write_nl('ind(icative)?'),
   read(Mod).

tense(Tense,Perf,Prog,Word) :-
   write('Which tense do you want for '),
   printquote(Word),
   questionmark,
   write_nl('present or past?'),
   read(Tense),
   write_nl('For the aspects just answer "yes" or "no"!'),
   write_nl('perfect?'),
   read(Perfect),
   check(Perfect,perfect,non_perfect,Perf),
   write_nl('progressive?'),
   read(Progressive),
   check(Progressive,progressive,non_progressive,Prog).


/* Syntyctic Function Assignment
   �ber die Auswahl des Arguments f�r die syntaktische Funktion
   Subjekt wird reguliert, ob der Satz aktiv oder passiv wird. */

assign_function(Word,[Single_Argument],Function,Role) :- !.

assign_function(have,[[Role,Restr,Term1],[goal,any,Term2]],Function,Role) :-
   !.

assign_function(Word,[[Role,Restr,Term],[goal,inf,InfPhrase]],Function, Role) :-
   !.

assign_function(Word,Args,Function,Role) :-
   write('Which term is '),
   write(Function),
   write(' of '),
   printquote(Word),
   questionmark,
   write_nl('Choose semantic role of term from following:'),
   writeargs(Args),
   read(Role).

/* ============================================================== */

