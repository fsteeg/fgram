/* Version vom 6.2.2003 */


:- initialization ensure_loaded('ex-rules.pl'). 
:- initialization ensure_loaded('print.pl').
:- initialization ensure_loaded('help.pl').
:- initialization ensure_loaded('underly.pl').
:- initialization ensure_loaded('ask-user.pl').
:- initialization ensure_loaded('lexicon.pl').

/* =================================================================== */

check_term(Kind,unexpressed,Role,Restriction,[[],[],unexpressed,[],[],[],[]],
    Args,Nlist,Alist,Alist,Q,Qt,I).
check_term(Kind,Noun,Role,Restriction,Term,A,Nlist,Alist, Alist1,Q,Qt,I) :-
   write('form_term in check_term'),nl,
   form_term(Kind,Noun,Role,Restriction,Term,Nlist,Alist,Alist1,Q,Qt,I).


/* ============================================================== */


/* HAUPTKLAUSEL */

fg :-
   underlying(Predication,Illocution,[],A,main_verb,finite,Raisability),!,
  
   write('expression_rules('),write(Illocution),comma,write(mainclause),comma,
   nl,write(Predication),comma,nl,write('[wh],Nlist,Punctuation)'),comma,
   write('writep(Punctuation),nl.'),nl,
 
    
   expression_rules(Illocution,mainclause,Predication,[wh],Nlist,Punctuation),
   writep(Punctuation),nl.

/* ============================================================== */
/* GENERATING THE UNDERLYING PREDICATION */

underlying(rel,Infinitive,Illocution,Alist,Alist1,adj,infinitive,no):- !.

underlying(rel,Infinitive,Illocution,Alist,Alist1,adj,infinitive,Raisability):-
  setdecl(Illocution),
   choose_pred(Word,Kind,Class,Forms,[Subj|Args],Satellites),!,
   form_predication(Word,Predicate,Term,Class,Forms,Args,Satellites,[],_,
                    Alist,Alist1,Qrole,Qterm,Illocution,infinitive,Raisability),
   newargs(Args,NewArgs),
   tense(Time,Perf,Prog,Word),
   object_assignment(Voice,Word,NewArgs,Object,Restargs),
   eq(Infinitive,[Class,Voice,[ind,Time,Perf,Prog,Num],[Word,
   Forms],[Object,Restargs,Satellites]]),
   setnil(Restargs), setnil(Satellites),
   write('Infinitive in underlying (rel): '), write(Infinitive),nl.


underlying(Infinitive,Illocution,Alist,Alist1,adj,infinitive,Raisability) :-
   setdecl(Illocution),
   choose_pred(Word,Kind,Class,Forms,[Subj|Args],Satellites),!, 


   form_predication(Word,Predicate,Term,Class,Forms,Args,Satellites,[],_,
                    Alist,Alist1,Qrole,Qterm,Illocution,infinitive,Raisability),
   newargs(Args,NewArgs),
   tense(Time,Perf,Prog,Word),
   set_passive(Kind,Voice),
   object_assignment(Voice,Word,NewArgs,Object,Restargs),
   write('Term: '),write(Term),nl,
   write('Infinitive(in underlying): '), write(Infinitive),
   eq(Infinitive,[Class,Voice,[ind,Time,Perf,Prog,Num],[Predicate,Forms],
                                                       /*statt [Word,Forms] */ 
   [Object,Restargs,Satellites]]),
   setnil(Restargs), setnil(Satellites),
   write('Infinitive: '), write(Infinitive),nl.

/*folgendes Programm ist eine Kopie des obigen mit kleinen Aenderungen fuer den Nebensatz von "want" */
underlying(Infinitive1,Illocution,Alist,Alist1,want,infinitive,Raisability) :-
   nl,write('Das richtige Underlying bei "want"!'),nl,
   setdecl(Illocution),
   choose_pred(Word,Kind,Class,Forms,[Subj|Args],Satellites),!,
   form_predication(Word,Predicate,Term,Class,Forms,Args,Satellites,[],_,
                    Alist,Alist1,Qrole,Qterm,Illocution,infinitive,Raisability),
   newargs(Args,NewArgs),
   tense(Time,Perf,Prog,Word),
   set_passive(Kind,Voice),
   object_assignment(Voice,Word,NewArgs,Object,Restargs),
   eq(Infinitive,[Class,Voice,[ind,Time,Perf,Prog,Num],[Predicate,Forms],
      [Object,Restargs,Satellites]]),
   setnil(Restargs), setnil(Satellites),
   check_have(have, Infinitive, Infinitive1),
   write('Restargs: '), write(Restargs),  write('Satellites: '), write(Satellites),nl,
   write('Infinitive: '), write(Infinitive),nl.


/* Das folgende Pr�dikat wird auskommentiert; wird anscheinend nicht
   aufgerufen.
setNewArgs(Word,[FirstArg,SecArg|Restargs],Newargs,no):-
    eq(NewArgs,[FirstArg,[goal,infinitive,_]|Restargs]).
setNewArgs(Word,Args,NewArgs,yes). */


underlying(Predication,Illocution,Alist,Alist1,Headverb,finite,Raisability) :-
   choose_pred(Word,Kind,Class,Forms,Oldargs,Satellites),!,
   firstarg_ins(Headverb,Predication,Oldargs,Args), /* nur f�r want */
   form_predication(Word,Predicate,Term,Class,Forms,Args,Satellites,[],_,
                    Alist,Alist1,Qrole,Qterm,Illocution,finite,Raisability),
   setdecl(Illocution),
   modality(Mod,Word,Headverb),!,  
   tense(Time,Perf,Prog,Word),!,
   nl,write_nl('Underlying Predication (Logical Form): '),
   write('Predop: '),
   outl([Mod,Time,Perf,Prog]),
   write('Predicate: '),
   outl(Predicate),
   write_nl('Arguments: '),
   outargs(Args),
   write_nl('Satellites: '),
   outargs(Satellites),
   nl,
   check_prop(Args,Proposition),
   check(Raisability),
   nl,write('Raisability: '),write(Raisability),write(' Word: '),write(Word),nl,
   write('Proposition: '),write(Proposition),nl,write('Raising: '),write(Raising),nl,
   !,
   ask_for_raising(Raisability,Word,Proposition,Raising,mainclause),
   write('ask for raising hat er geschafft!'),nl,
   raise(Word,Proposition,Args,NewArgs,Raising),
   write_nl('Arguments: '),
   outargs(Args),
   newargs(Args,NewArgs),
   write_nl('NewArgs: '),
   outargs(NewArgs),
   nl,write('vor so-assignment, Qrole: '), write(Qrole),nl,
   so_assignment(Voice,Word,NewArgs,Theme,Subject,Object,Restargs,
                 Satellites,Satellites1,Qrole,Qterm),!,
   print_fsp(Voice,Mod,Time,Perf,Prog,Word,Theme,Subject,Object,
                Restargs,Satellites1),                             
   eq(Predication,[Class,Voice,[Mod,Time,Perf,Prog,Num],[Predicate,Forms],
     [Theme,Subject,Object,Restargs,Satellites1]])
     /*,setdecl(Illocution)*/.

firstarg_ins(want,[A,B,C,D,[Ill,Firstarg|Restargs]],Args,Args):-
   var(Firstarg),!.

firstarg_ins(want,[A,B,C,D,[Ill,Firstarg|Restargs]],[[Role,Restr,X]|Oldrest],[Firstarg|Oldrest]).
 

firstarg_ins(Headverb,Predication,Args,Args).

inf_rel_underlying(Relnoun,Infinitive,Illocution,Alist,Alist1,adj,infinitive,R):-
   choose_pred(Word,Kind,Class,Forms,[Subj|Args],Satellites),!,
 /*  Kind <- form_predication(Word,Predicate,Term,Class,Forms,Args,Satellites,[],_,
                    Alist,Alist1,Qrole,Qterm,Illocution,infinitive,Raisability),
   statt Kind nur arg_insertion ,sp�ter auch sat insertion und Verallgemeinerung des
   n�chsten Befehls,eventuell eigenes Praedikat */  
   write('Infinitive1:Args '),write(Args),nl,
   eq(Args,[[goal,Restriction,Relnoun]|Restargs]),
   write('Infinitive2:Args '),write(Args),nl,
   newargs(Args,NewArgs),
   write('Infinitive3:NewArgs '),write(NewArgs),nl,
   tense(Time,Perf,Prog,Word),
   object_assignment(Voice,Word,NewArgs,Object,Restargs),
   write('Infinitive4:NewArgs '), write(NewArgs),nl,
   eq(Infinitive,[Class,Voice,[ind,Time,Perf,Prog,Num],[Word,
   Forms],[Object,Restargs,Satellites]]),
   setnil(Restargs), setnil(Satellites),
   write('Infinitive(inf_rel_underlying): '), write(Infinitive),nl.
              
/* FULLY SPECIFIED PREDICATION */

print_fsp(Voice,Mod,Time,Perf,Prog,Word,Theme,Subject,Object,Restargs,
          Satellites1) :-
   write(' Fully Specified Predication: '),
   write('Predop: '),
   write(Voice),
   write(', '),
   outl([Mod,Time,Perf,Prog]),
   write('Predicate: '),
   outl(Word),
   setnil(Theme),
   write('Theme: '),
   outl(Theme),
   write('Subject: '),
   outl(Subject),
   setnil(Object),
   write('Object: '),
   outl(Object),
   setnil(Restargs),
   write('Restargs: '),
   outargs(Restargs),
   nl,
   write('Satellites: '),
   setnil(Satellites1),
   outargs(Satellites1),
   lines(2).                                    

check_prop(Args,Proposition) :-
   eq(Args,[Head,[Role,proposition,Proposition]|Tail]).
check_prop(Args,Proposition) :-
   eq(Args,[[Role,proposition,Proposition]|Tail]).
check_prop(Args,Proposition) :-
   eq(Args,[Head,[Role,infinitive,Proposition]|Tail]).
check_prop(Args,Proposition) :-
   eq(Args,[[Role,infinitive,Proposition]|Tail]).       
check_prop(Args,Proposition).

check_raising(Args,Proposition,yes):-
   check_prop(Args,Proposition),!.

check_raising(Args,Proposition,no).

check(Raisability):-
   eq(Raisability,no).
check(Raisability):-
   eq(Raisability,yes).


form_predication(Word,Word,[P,Termop,Relnoun,GramInfo,Modif,Rphr,Relcl],Class,Forms,Args,
                 Satellites,Role,Relnoun,Alist,Alist3,Qrole,Qterm,Ill,Mode, Raisability) :-
   nounlist(Nounlist),
   write('You have chosen a verbal predicate '),nl,
   write('Args(in form_predication): '),write(Args),nl, 
   role_for_relnoun(Word,Args,Args1,Role,[P,Termop,Relnoun,GramInfo,Modif,Rphr,[]],
                      Alist,Alist1),
   write('After role_for_relnoun Word: '),write_nl(Word), 

   write('Args1: '),write_nl(Args1),nl,
   eq(Args1,Args2),
   argument_insertion(Word,Args1,Args2,Nounlist,Alist1,Alist2,Qrole,Qterm,Ill,
   Mode,Raisability),
   write('Args: '),write_nl(Args),nl,
   write('Args1: '),write_nl(Args1),nl,
   write('Args2: '),write_nl(Args2),nl,
   satellite_insertion(Word,Satellites,Nounlist,Alist2,Alist3,Qrole,Qterm,Ill),
   setnil(Satellites).

form_predication(Word,Word,Term,Class,Forms,Args,Satellites,Role,Relnoun,
                 Alist,Alist4,Qrole,Qterm,Ill,Mode, Raisability) :-
   nounlist(Nounlist),
   write('You have chosen an adjectival predicate '),nl,
   nl,write('Raisability: '),write(Raisability),write(' Word: '),write(Word),nl,
/* an diese Stelle check raising in relclause :                 */
   nl,
   check_raising(Args,Proposition,Raisability),
   nl,write('Raisability: '),write(Raisability),write(' Word: '),write(Word),nl,
   write('Proposition: '),write(Proposition),nl,
   write('Args(in form_predication): '),write(Args),nl,
/* an diese Stelle underlying infinitive:               

geht auch rein wenn adj. nicht im rel 
   underlying(rel,Infinitive,Illocution,Alist,Alist1,adj,infinitive,Raisability),*/
write('Args in formpredadj :'), write(Args),
   role_for_relnoun(Word,Args,Args1,Role,Term,/*Term statt [P,T,Relnoun,GramInfo,Modif,Rphr,[]]*/
                      Alist1,Alist2),
   write('After role_for_relnoun Word: '),write_nl(Word),
   write('Args1: '),write_nl(Args1),nl,
   argument_insertion(Word,Args1,Args,Nounlist,Alist2,Alist3,Qrole,Qterm,Ill,
   Mode,Raisability),
   satellite_insertion(Word,Satellites,Nounlist,Alist3,Alist4,Qrole,Qterm,Ill),
   setnil(Satellites).

form_predication(Noun,Term,Term,Class,Forms,Args,Satellites,Role,Relnoun,
   Alist,Alist4,Qrole,Qterm,Ill,Mode, Raisability) :-
   write('You have chosen a nominal predicate '),nl,
   nounlist(Nounlist),
   form_term(noun, Noun, Role, Restriction, Term, Nounlist, Alist, Alist1,
             _, _, Ill),
   write('Args(nach formterm in form_predication): '),write(Args),nl,  
   role_for_relnoun(Noun,Args,Args1,Role,[P,T,Relnoun,GramInfo,Modif,Rphr,[]],
                      Alist1,Alist2),
   write('After role_for_relnoun Relnoun: '),write_nl(Relnoun),
   write('Args1: '),write_nl(Args1),nl,
   /*  eq(Args,Args1),  ist unlogisch */
   argument_insertion(Noun,Args1,Args,Nounlist,Alist2,Alist3,Qrole,Qterm,Ill,
   Mode,Raisability),
   satellite_insertion(Noun,Satellites,Nounlist,Alist3,Alist4,Qrole,Qterm,Ill),
   setnil(Satellites).

argument_insertion(Word,[],X,Y,A,A,Q,T,I,M,R).

argument_insertion(Word,[[Role,Restriction,Term]|Tailargs],Args1,Nounlist,Alist,  
   Alist2,Qrole,Qterm,Ill,Mode,R) :-
   write('entered arg_ins Restriction: '),write(Restriction),lines(2),
   write('Alist2 in arg_ins vor askterm = '), write(Alist2),nl,
   askterm(Word,Role,Restriction,Args1,Term,Nounlist,Alist,Alist1,Qrole,
           Qterm,Ill,Mode,R),
   write('Alist2 in arg_ins nach askterm = '), write(Alist2),nl,
   argument_insertion(Word,Tailargs,Args1,Nounlist,Alist1,Alist2,Qrole,Qterm, Ill,Mode,R).


 
inf_argument_insertion(Word,[[Role,infinitive,[rel,Termop,Relnoun,GramInfo,Modif,Rphr,[]]]|Tailargs],
                   [[Role,infinitive,Term]|Tailargs],Args1,Nounlist,Alist,Alist2,Qrole,Qterm,Ill,Mode,R):-
   inf_rel_askterm([rel,Termop,Relnoun,GramInfo,Modif,Rphr,[]],
                 Word,Role,infinitive,Args,Infinitive,Nlist,Alist,Alist1,Q,Qt, Illocution,M,yes),
   eq(Args,[[argument,infinitive,Infinitive]]),
   inf_args(Infinitive,Infargs),
   choose_role(Relnoun,Args,Role),
   noun(Relnoun,Class,[Plural,Gender],[[R,Res,X]],Sat),
   write('Args in role for relnoun(Inf_arg_insertion): '),write(Args),nl,
   raise_rel(Infinitive,NewArgs),
   write('In inf_arg_insertion. Role: '), write(Role),write('   Termop: '),write(Termop),nl,
   delete_arg(Role,Term,NewArgs,Args1).

inf_args( [Action,Voice,Gramminfo,[Verb,Forms],Infargs],Infargs).


satellite_insertion(Word,Satellites,Nounlist,Alist,Alist1,Qrole,Qterm,
   Ill) :-
   eq(Satlist,[beneficiary,direction,instrument,loc_in,loc_on,manner,purpose,reason,
      time_point,time_space]),
   ask_for_satellites(Word, 'a',Answer),
   insert_satellites(Word,[],Satellites,Nounlist,Term,Satlist,Answer,
                     Alist,Alist1,Qrole,Qterm,Ill).

insert_satellites(Word,Sat,Sat1,Nounlist,Term,Satlist,no,Alist,Alist,
   Qrole,Qterm,Ill) :-
   reverse(Sat,Sat1).
insert_satellites(Word,Satellites,Satellites2,Nounlist,Term,Satlist,yes,
   Alist,Alist2,Qrole,Qterm,Ill) :-
   write_nl('Which role do you want for satellite?'),
   printlist(Satlist),
   read(Role),
   del(Role,Satlist,Satlist1),
   insert_restriction(Role,Restr),
   askterm(Word,Role,Restr,Args,Term,Nounlist,Alist,Alist1,Qrole,Qterm
   ,Ill,mode,R),
   add_member([Role,Restr,Term],Satellites,Satellites1),
   ask_for_satellites(Word,'another',Answer),
   insert_satellites(Word,Satellites1,Satellites2,Nounlist,Term1,Satlist1,
   Answer,Alist1,Alist2,Qrole,Qterm,Ill).

insert_restriction(reason,proposition).
insert_restriction(purpose,infinitive).
insert_restriction(Role,Role).


/* TERM FORMATION */

form_term(verb,Verb,Role,Restr,Verb,Nlist,Alist,Alist,Q,Qt,Ill).
form_term(adj,Adj,Role,Restr,Adj,Nlist,Alist,Alist,Q,Qt,Ill).
form_term(Kind,Noun,Role,Restr,Term,Nlist,Alist,Alist3,Q,Qt,Ill) :-
   member(Noun,Nlist),
   !,
   noun(Noun,Class,[Plural,Gender],[[R,Res,X]],Sat),
   ask_for_modifier(Noun,an,Answer),
   adjlist(Adjlist),
   insert_modifier(Noun,[],Modif,Adjlist,Answer),
   add_member([Termop,Noun,[Res,Plural,Gender],Modif],Alist,
     Alist1),
  /* askof(Kind,Noun,Ans),
   of(Noun,Nlist,Relphrase,Alist1,Alist2,Ans), */
   write('Is determiner of '),
   printquote(Noun),
   write_nl(' def,indef,total,prox,nprox,neg,qdef,or qindef?'),
   read(Det),
   number(Kind,Number),
   eq(Termop,[Det,Number]),
   check_det(Det,Role,Term,Q,Qt,Ill),
   write('vor rel in form_term: Termop '),write(Termop),nl,
   rel(Termop,Noun,[Res,Plural,Gender],Relclause,Alist2,Alist3),
   ask_for_raising(Kind,Relclause,Reply),
   raise_adj(Kind,Modif,Modif1,Relclause,Relclause1,Reply),
  /* macht aus "Jo is a man, who talks." "Jo is a talking man." */  
   eq(Term,[P,Termop,Noun,[Res,Plural,Gender],Modif1,Relphrase,Relclause1]),
   write('This is the formed Term: '),write(Term),nl.

form_term(argument,wh,Role,Restr,Term,Nlist,Alist,Alist,Role,Term,
   question) :-
   ask_gender(Role,Restr,Gender),
   eq(Term,[question,[[],sing],wh,[S,P,Gender],[],[],Rel]),
   write('Term: '),write(Term),nl.


form_term(argument,ProperNoun,Role,Restr,Term,Nlist,Alist,Alist2,Q,Qt,
   Ill) :-
   properNoun(ProperNoun,GramInfo,Alist,Alist1),
   rel([[],sing],ProperNoun,GramInfo,Relclause,Alist1,Alist2),
   eq(Term,[_,[[],sing],ProperNoun,GramInfo,[],[],Relclause]),
   write('Term: '),write(Term),nl.

raise_adj(noun,Modif,[Newword|Modif],[Class,Voice,Predop,[Word,Forms],[[],
   Subject,[],Inf,Sat1]],Inf,yes):-
   check_class(Class,Word,Newword).
raise_adj(Kind,Modif,Modif,Relclause,Relclause,no).

check_class(Class,Word,Newword):-
   member(Class,[action,process,position,state]),
   suffix(Word,ing,Newword).

check_class(Class,Word,Word).

check_det(Det,Role,Term,Role,Term,question) :-
   firstletter('q',Det),
   !.

check_det(Det,R,T,Q,Qt,I).

/* RELATIVE CLAUSE */

rel(Top,Noun,GramInfo,Relclause,Alist,Alist1) :-
   askrel(Noun,Answer),
   relclause(Top,Noun,GramInfo,Relclause,Answer,Alist,Alist1).

relclause(Top,Noun,GramInfo,Relclause,no,Alist,Alist) :-
   !,
   eq(Relclause,[]).

relclause(Termop,Relnoun,GramInfo,Relclause,yes,Alist,Alist1) :-
   choose_pred(Word,Kind,Class,Forms,Args,Satellites),!,
   nl,write('Kind: '),write(Kind),nl,
   form_predication(Word,Predicate, [rel,Termop,Relnoun,GramInfo,Modif,Rphr,[]],
   Class,Forms,Args,Satellites,Role,Relnoun,
   Alist,Alist1,Q,Qt,rel,finite,Raisability),
   write('Args in relclause: '),write(Args),nl,
   check_prop(Args,Proposition),
   ask_for_raising(Raisability,Word,Proposition,Raising,relclause),
   raise(Word,Proposition,Args,NewArgs,Raising),!,
   modality(Mod,Word,[]),
   tense(Time,Perf,Prog,Word),
   so_assignment(Voice,Word,NewArgs,Theme,Subject,Object,Restargs,Restargs1,Satellites,
   Satellites1,Qrole,Relnoun,[rel,Termop,Relnoun,GramInfo,Modif,Rphr,[]]),!,
   eq(Relclause,[Class,Voice,[Mod,Time,Perf,Prog,Num],[Word,Forms],
   [Theme,Subject,Object,Restargs1,Satellites1]]),
   write('Relative Clause: '),nl,
   print_fsp(Voice,Mod,Time,Perf,Prog,Word,Theme,Subject,Object,
   Restargs1,Satellites1).


/* ============================================================== */

  /*RAISING */

raise(easy,[Class,Voice,Predop,P,[O,R,S]],Args,NA,Term,no) :-
   ask_for_raising(easy,[Class,Voice,[ind,Tse,Pf,Pg,Num],[V,Vf],[T,
   [P,T,infinitive_phrase,G,M,R],Object,Restargs,Sat]],Raising),
   PROGRAM=..[Raising,Term,Class,Voice,Predop,P,O,R,S,NA], call(PROGRAM).
/*TErm bei aufruf und Program wieder rein */
raise(easy,[Class,Voice,Predop,P,[O,R,S]],Args,NA,Term,yes) :-
   ask_for_raising(easy,[Class,Voice,[ind,Tse,Pf,Pg,Num],[V,Vf],[T,
   [P,T,infinitive_phrase,G,M,R],Object,Restargs,Sat]],Raising),
   PROGRAM=..[Raising,Term,Class,Voice,Predop,P,O,R,S,NA], call(PROGRAM).
/* Objekt =[] */
raise(easy,[Class,Voice,Predop,P,[[],R,S]],Args,NewArgs,yes) :-
   eq(InfPhrase,[Class,Voice,Predop,P,[[],R,S]]),
   eq(NewArgs,[[subject,any,InfPhrase]]).

raise(easy,[Class,Voice,Predop,P,[O,R,S]],Args,NewArgs,yes) :-
   eq(InfPhrase,[Class,Voice,Predop,P,[[],R,S]]),
   eq(NewArgs,[[subject,any,O],[argument,infinitive,InfPhrase]]).


/* Infinitive Raising */
raise(easy,[Class,Voice,Predop,P,[O,R,S]],Args,NewArgs,no) :-
   ask_for_raising(yes,easy,[Class,Voice,Predop,P,[O,R,S]],Raising,Clause,inf),
   (Raising = no, delete_arg(Role,[[],[],unexpressed,[],[],[]],Args,NewArgs);
    Raising = yes,
   eq(NewArgs,[[subject,any,[Class,Voice,Predop,P,[O,R,S]]]])).


raise(Verb,Predication,Args,NewArgs,no) :-
   delete_arg(Role,[[],[],unexpressed,[],[],[]],Args,NewArgs).


raise(Verb,Predication,Args,Args,no).

raise(Verb,[Class,Voice,Predop,[Word,Forms],[Theme,[P,Termop,Noun,Gram
   ,Modif,Rphr,Rel],Obj,Restargs,Sat]],[[Role1,Restr1,[p1,Termop1,Noun1
   ,Gram1,Modif1,Rphr1,Rel1]]|Arg2],NewArgs,yes) :-
   eq(InfPhrase,[goal,inf,[Class,Voice,Predop,[Word,Forms],[Obj,Restargs,Sat]]]),
   createNewArgs(Verb,NewArgs,[Role1,Restr1,[P1,Termop1,Noun1,Gram1,
   Modif1,Rphr1,Rel1]],[goal,any,[P,Termop,Noun,Gram,Modif,Rphr,Rel]],
   InfPhrase).

raise(Verb,[Class,Voice,Predop,[Word,Forms],[Theme,[P,Termop,Noun,Gram
   ,Modif,Rphr,Rel],Obj,Restargs,Sat]],[[argument,proposition,[Cl1,Vo1,
   Predop1,[Pred1,Forms1],[Th1,[P1,Termop1,Noun1,Gram1,Modif1,Rphr1,
   Rel1],Obj1,Rargs,S]]]|Arg2],NewArgs,yes) :-
   eq(InfPhrase,[goal,inf,[Class,Voice,Predop,[Word,Forms],[Obj,Restargs,Sat]]]),
   createNewArgs(Verb,NewArgs,[subject,any,[P1,Termop1,Noun1,Gram1,Modif1,
   Rphr1,Rel1]],InfPhrase). 

yes(Term,Class,Voice,Predop,P,O,R,S,NewArgs) :-
   eq(InfPhrase,[Class,Voice,Predop,P,[O,R,S]]),
   eq(NewArgs,[[subject,any,InfPhrase]]).

/* ohne Term, weil nicht benutzt */

yes(Class,Voice,Predop,P,O,R,S,NewArgs) :-
   eq(InfPhrase,[Class,Voice,Predop,P,[O,R,S]]),
   eq(NewArgs,[[subject,any,InfPhrase]]).
   
   %original
   %no(Term,Class,Voice,Predop,P,O,R,S,NA) :-
   %eq(Term,[Class,Voice,Predop,P,[O,R,S]]).
   

no(Term,Class,Voice,Predop,P,O,R,S) :-
   eq(Term,[Class,Voice,Predop,P,[O,R,S]]).


raise_rel([Class,Voice,Predop,P,[O,R,S]],NewArgs) :-
  /* eq(InfPhrase,[Class,Voice,Predop,P,[O,R,S]]),
   eq(NewArgs,[[subject,any,InfPhrase]]). */

   eq(InfPhrase,[Class,Voice,Predop,P,[[],R,S]]),
   eq(NewArgs,[[subject,any,O],[argument,infinitive,InfPhrase]]).



createNewArgs(want,NewArgs,[Role1,Restr1,[P1,Termop1,Noun1,Gram1,Modif1,
   Rel1,Rel]],[goal,any,[P,Termop,Noun,Gram,Modif,Rphr,Rel]],InfPhrase) :-
   eq(Noun,Noun1),
   !,
   eq(InfPhrase,[goal,inf,[Class,Voice,Predop,[Word,Forms],[Obj,Restargs,
   Sat]]]),
   check_have(Word,InfPhrase,InfPhrase1),!,
   eq(T,[Role1,Restr1,[P1,Termop1,Noun1,Gram1,Modif1,Rphr1,Rel1]]),
   eq(NewArgs,[T,InfPhrase1]).  

createNewArgs(Verb,NewArgs,Arg1,NewArg2,InfPhrase) :-
   eq(NewArgs,[Arg1,NewArg2,InfPhrase]).

createNewArgs(Verb,NewArgs,Arg1,InfPhrase) :-
   eq(NewArgs,[Arg1,NewArg2,InfPhrase]).

/* ============================================================== */

/* HAVE_UNTERDRUCKUNG */
expr(InfPhrase,InfPhrase).

suppr(InfPhrase,InfPhrase1) :-
   trace, eq(InfPhrase,[goal,inf,[Class,Voice,Predop,[Word,Forms],[Obj,Restargs,
   Satellites]]]),
   eq(InfPhrase,[Class,Voice,Predop,[Word,Forms],[Obj,Restargs,
   Satellites]]),
   /*eq(InfPhrase1,[goal,any,Obj]).*/ /*Restargs und Satellites von 'have' geloescht*/
   eq(InfPhrase1,[Obj, Restargs, Satellites]).


/* ============================================================== */
  
  /* SUBJEKT_OBJEKT ZUWEISUNG   */

so_assignment(passive,easy,[[argument,infinitive,Restargs]|Tail],Theme,Qterm,
   [],[[argument,inf,Restargs|Tail]],Sat,Sat,Qrole,Qterm).

so_assignment(passive,easy,[[subject,any,Subject]|Restargs],Theme,Subject,[],
   Restargs,Sat,Sat,Qrole,Qterm).

so_assignment(passive,eager,[[first_argument,animate,Subject],[second_argument,
   infinitive,Restargs]|Tail],Theme,Subject,[],[[second_argument,inf,Restargs|Tail]],Sat,Sat,Qrole,
   Qterm).

so_assignment(active,seem,[[argument,proposition,Restargs]|Tail],Theme,[],[],
   [Restargs|Tail],Sat,Sat,Qrole,Qterm).


so_assignment(active,want,[[experiencer,human,Subject],[goal,proposition,Restargs]|Tail],Theme,Subject,[],[goal,inf,Restargs|Tail],Sat,Sat,Qrole,
   Qterm). 


so_assignment(Voice,Word,Args,Theme,Subject,Object,Restargs,Sat,Sat1,Qrole,
   Qterm) :-
   check_subject(Voice,Args,Args1),
   subject_assignment(Voice,Word,Args1,Theme,Subject,Args2,Restargs,Sat,
   Sat1,Qrole,[mainclause,Termop,Noun,GramInfo,Modif,Rphr,[]]),!, 
   write('nach subj.-ass mainclause:'),nl,write('Voice: '),
   write(Voice),nl,write('Args2: '),write(Args2),nl,
   object_assignment(Voice,Word,Args2,Args3,Theme,Object,Restargs),!,
   write('nach obj.-ass mainclause:'),nl,write('Voice: '),
   write(Voice),nl,write('Object: '),write(Object),nl.

so_assignment(Voice,Word,Args,Theme,Subject,Object,Restargs,Sat,Sat1,Qrole,
   Qterm) :-
   check_subject(Voice,Args,Args1),
   subject_assignment(Voice,Word,Args1,Theme,Subject,Args2,Restargs,Sat,
   Sat1,Qrole,[question,Termop,Noun,GramInfo,Modif,Rphr,[]]),!, 
   write('nach subj-ass  question:'),nl,write('Voice: '),
   write(Voice),nl,write('Object: '),write(Object),nl,
   object_assignment(Voice,Word,Args2,Args3,Theme,Object,Restargs).

so_assignment(Voice,Word,Args,Theme,Subject,Object,Restargs,Restargs1,Sat,Sat1,Qrole,Relnoun,
  [rel,Termop,Relnoun,GramInfo,Modif,Rphr,[]]) :-
   subject_assignment(Voice,Word,Args,Theme,Subject,Args1,Restargs,Sat,
   Sat1,[rel,Termop,Relnoun,GramInfo,Modif,Rphr,[]]),!, 
   write('nach subj-ass relclause: '),write('Voice: '),write(Voice),nl,
   check_subject(Subject,Relnoun,Args1,Args2,Theme),!,
   write('Restargs: '),write(Restargs),nl, write('Restargs1: '),write(Restargs1),nl,
   check_subject(Subject,Relnoun,Restargs,Restargs1,Theme),!,
   write('Restargs: '),write(Restargs),nl, write('Restargs1: '),write(Restargs1),nl,
   write('Args2: '),write(Args2),nl,
   object_assignment(Voice,Word,Args2,Object,Restargs1,
   [rel,Termop,Relnoun,GramInfo,Modif, Rphr,[]]),!,
   write(Voice),nl,write('Object in relclause after Object assignment: '),write(Object),nl.

check_subject(passive,[[Role,Restr,[[],[],unexpressed,[],[],[],[]]]|Tailargs],Tailargs).
check_subject(Voice,Args,Args).

check_subject([[],Termop,Relnoun,Gram,Mod,Phrase,[]],Relnoun,Args,Args,Theme).

check_subject([question,Termop,Relnoun,Gram,Mod,Phrase,[]],Relnoun,Args,Args,Theme).

check_subject(Subject,Relnoun,Args,Args,Theme):-
   eq(Subject,[rel,Termop,Relnoun,Gram,Mod,Phrase,[]]),
   setnil(Theme).
check_subject(Subject,Relnoun,Args,Args1,Theme):-
   eq(Term,[rel,Termop,Relnoun,Gram,Mod,Phrase,[]]),
   member([Role,Restr,Term],Args),
   eq(Theme,[Role,Term]),
   delete_arg(Role,Term,Args,Args1).

check_subject(Subject,Relnoun,Args,Args1,Theme):-
   write(" This is a mistake in check_subject! "),nl. 

subject_assignment(passive,Word,[[subject,any,Subject],[argument,infinitive,Inf]],[],
                                 [relative,Termop,Noun,GramInfo,[],[],[]],[],[Inf],Sat,Sat1,
                                 Role,[infinitive,Termop,Noun,GramInfo,Modif,Rphr,[]]).
subject_assignment(active,Word,[[subject,any,Subject]|Args2],Theme,Subject,
   Args2,R,Sat,Sat1,Role1,[P,Termop,Noun,GramInfo,Modif,Rphr,[]]).

subject_assignment(Voice,Word,Args,Theme,Subject,Args1,Restargs,Sat,
   Sat1,Role1,[mainclause,Termop,Relnoun,GramInfo,Modif,Rphr,[]]) :-
   assign_function(Word,Args,subject,Role),!,
   nl,write('Role: '),write(Role),write(' Role1: '),write(Role1),write('P: '),write(P),nl,
 /*  check_roles(Role,Role1,Theme,Subject,[mainclause,Termop,Relnoun,GramInfo,Modif, Rphr,[]],
    Args,Args1,Sat,Sat1),
   write('nach check_roles in subject_assignment '),*/nl,
   delete_arg(Role,Term,Args,Args1),
   write('nach delete_arg, Args1: '),write(Args1),nl,
   eq(Subject,Term),
   write('Subject: '),write(Subject),nl,
  /* check_subject(Subject,Relnoun,Args2,Args3,Theme),
   write('Args2 after check_subject: '), write(Args2),write(' Args3: '),write(Args3),nl,
   wird in der mainclause nicht benoetigt */
   determineVoice(Word,Role,Voice),
   write('vor PROGRAM in subj-ass,mainclause, Args1: '),write(Args1),lines(2),
   PROGRAM=..[Voice,Args1,Restargs,Sat,Sat1], call(PROGRAM).  

subject_assignment(Voice,Word,Args,Theme,Subject,Args1,Restargs,Sat,
   Sat1,[rel,Termop,Relnoun,GramInfo,Modif,Rphr,[]]) :-
   assign_function(Word,Args,subject,Role),!,
   nl,write('Role: '),write(Role),nl,
  /* check_roles(Role,Role1,Theme,Subject,[rel,Termop,Relnoun,GramInfo,Modif, Rphr,[]],
    Args,Args1,Sat,Sat1), */ 
   write('nach rausgenommenen check_roles in subject_assignment '),nl,
   delete_arg(Role,Term,Args,Args1),
   write('nach delete_arg, Args1: '),write(Args1),nl,
   eq(Subject,Term),
   write('Subject: '),write(Subject),nl,
  /* check_subject(Subject,Relnoun,Args1,Args2,Theme),
   write('Args1 after check_subject: '), write(Args1),write(' Args: '),write(Args2),
    im so-assignment Programm vorhande */
   determineVoice(Word,Role,Voice),
   write('vor PROGRAM in subj-ass, relclause, Args1: '),write(Args1),lines(2),
   PROGRAM=..[Voice,Args1,Restargs,Sat,Sat1], call(PROGRAM).

check_roles(Role,Role1,Theme,Subject,[rel,Termop,Relnoun,GramInfo,Modif,Rphr
   ,[]],Args,Args,Sat,Sat) :-
   eq(Role,Role1),
   !,
   eq(Theme,[]).

check_roles(Role,Role1,Theme,Subject,[P,[Det,Num],Noun,GramInfo,Modif,
   Rphr,[]],Args,Args1,Sat,Sat1) :-
   eq(Theme,[Role1,[P,[Det,Num],Noun,GramInfo,Modif,Rphr,[]]]),
   !,
   deleteTheme(Role1,Args,Args1,Sat,Sat1).


check_roles(Role,Role1,Theme,Subject,[P,[Det,Num],Noun,GramInfo,Modif,
   Rphr,[]],Args,Args1,Sat,Sat1).

object_assignment(active,P,[],[],Restargs) :- !.
object_assignment(passive,P,[],[],Restargs) :- !.
object_assignment(active,Word,[[Role,Restr,Term],[goal,inf,[Class,Voice,
   Predop,[P,Pforms],[O,Rest,St]]]],Object,Restargs) :-
   !,
   eq(Object,Term),
   eq(Restargs,[goal,inf,[Class,Voice,Predop,[P,Pforms],[O,Rest,St]]]).
object_assignment(active,Verb,[[goal,any,Term],Args,Sat,Args1],Object,
                 Restargs) :-
   !,
   eq(Object,[Term,Args,Sat]),
   del([[goal,any,Term],Args,Sat],Args1,Restargs).

object_assignment(active,Word,[],[],Theme,Object,Restargs).

object_assignment(passive,Word,[],[],Theme,Object,Restargs).

object_assignment(passive,Word,Args,[],Theme,[],Restargs).

object_assignment(Voice,Word,[],[],Restargs,
   [rel,Termop,Relnoun,GramInfo,Modif, Rphr,[]]).

object_assignment(passive,Word,Args2,[],Restargs,
   [rel,Termop,Relnoun,GramInfo,Modif, Rphr,[]]). /*das obere war bei passivem Relsatz schiefgegangen*/

object_assignment(active,Verb,Args,Args1,Theme,Object,Restargs) :-
   !,
   assign_function(Verb,Args,object,Role),
   /*eq(Args,[[Role,Restr,Term]|Tail]), 4.1.2000 reingetan, weil Term anonym */
   eq(Object,Term),
   delete_arg(Role,Term,Args,Restargs).

object_assignment(active,Verb,Args,Object,Restargs,
                 [rel,Termop,Relnoun,GramInfo,Modif, Rphr,[]]) :-
   !,
   assign_function(Verb,Args,object,Role),
   eq(Args,[[Role,Restr,Term]|Tail]),/* 4.1.2000 reingetan,weil Term anonym*/
   eq(Object,Term),
   delete_arg(Role,Term,Args,Restargs).


object_assignment(passive,Verb,[[Role,Restr,Term],[goal,inf,[Class,Voice,
   Predop,[P,Pforms],[O,Rest,St]]]],Object,Restargs) :-
   !,
   eq(Object,[]),
   eq(Restargs,[[Role,Restr,Term],[goal,inf,[Class,Voice,Predop,[P,Pforms],
      [O,Rest,St]]]]).
object_assignment(active,Verb,Args,Object,Restargs) :-
   write('Args(in object_asssignmenmt): '),write(Args),nl,
   assign_function(Verb,Args,object,Role),
   eq(Object,Term),
   delete_arg(Role,Term,Args,Restargs).

object_assignment(passive,Verb,Args,Object,Restargs) :-
   eq(Object,[]),
   write('Args(in object_asssignmenmt): '),write(Args),nl,
   eq(Args,[[Role,Restr,Term]|Restargs]).

/* ============================================================== */

/* Aktiv /(Passiv steht in den expression rules,Aktiv auch

active(Args2,Restargs).

active(Args2,Restargs,Sat,Sat).*/





/* ============================================================== */


/* Determining Voice */

determineVoice(Word,argument,passive) :- !.

determineVoice(Verb,Role,Voice) :-
   verb(Verb,C,_,[[FirstArg,Restr,X1]|Tail],_),write('vor voice'),nl,
   write(Role),write(' '),write(FirstArg),nl,
   voice(Role,FirstArg,Voice).

voice(Role,FirstArg,active) :-
   eq(Role,FirstArg),
   !.

voice(_,_,passive).

/* noun and adj in inf_phrase */

set_passive(noun,passive).

set_passive(adj,passive).

set_passive(Kind,Voice).

/* ============================================================== */

deleteTheme(Role,Args,Args1,Sat,Sat) :-
   delete_arg(Role,Term,Args,Args1).

deleteTheme(Role,Args,Args,Sat,Sat1) :-
   delete_arg(Role,Term,Sat,Sat1).

delete_arg(goal,[Term,Args,Sat],Args1,Restargs) :-
   member([[goal,any,Term],Args,Sat],Args1),
   del([[goal,any,Term],Args,Sat],Args1,Restargs).

delete_arg(Role,Term,Args,Restargs) :-
   member([Role,Restriction,Term],Args),
   del([Role,Restriction,Term],Args,Restargs).

/* ============================================================== */






