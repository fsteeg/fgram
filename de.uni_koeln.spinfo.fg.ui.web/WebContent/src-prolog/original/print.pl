
/* AUSDRUCKEN   fg */


outargs([]) :- !.

outargs([FirstArg|Restargs]) :- 
   outl(FirstArg),
   outargs(Restargs).

writeroles([]) :- nl,!.
writeroles([[Role,Restr,Term]|Tail]):-
write(Role),
write('  '),
writeroles(Tail).

writeargs([]) :- !.

writeargs([[goal,any,Term],Restargs,Satellites]) :-
   writeargs([goal,any,Term]).

writeargs([[Role,proposition,Term]|Tail]) :-
   write('   '),
   printlist([Role,proposition]),
   writeargs(Tail).

writeargs([[goal,inf,InfPhrase]|Tail]) :-
   !,
   writeargs(Tail).

writeargs([[argument,infinitive,InfPhrase]|Tail]) :-
   !,
   writeargs(Tail).

writeargs([[Role,Restr,[P,T,Noun,GramInfo,Modif,Rphr,Relclause]]|Tail]) :-
   write('   '),
   printlist([Role,Noun]),
   writeargs(Tail).

writeargs([[Role,Restr,[question,[[],sing],wh,GramInfo,Modif,Rphrase,
   Relclause]]|Tail]) :-
   write('   '),
   printlist([Role,question]),
   writeargs(Tail).

/* ex-rules */


printargs([],C,Nlist,Nlist) :- !.

printargs([Class,Vce,Verbop,V,[Theme,Subject,Object,Restargs,Satellites]],state,Nlist,
   Nlistout) :-
   printterm([Class,Vce,Verbop,V,[Theme,Subject,Object,Restargs,Satellites]],
Case,Clause,Nlist,Nlistout,no).

printargs([[Role,Restriction,Term]|Tail],Class,Nlist,Nlistout) :-
PROGRAM=..[Role,Term,Class,Nlist,Nlist1,C,no], 
   call(PROGRAM), 
   printargs(Tail,Class,Nlist1,Nlistout).

printargs([[Class,Vce,Verbop,V,[[],Subject,[],[],[]]]],state,Nlist,
   Nlistout) :-
   printterm([Class,Vce,Verbop,V,[[],Subject,Object,Restargs,Satellites]],
Case,Clause,Nlist,Nlistout,no).

printargs([goal,inf,Infinitive|Tail],Class,Nlist,Nlistout) :-
   printterm(Infinitive,Case,Clause,Nlist,Nlist1,no),
   printargs(Tail,Class,Nlist1,Nlistout).
/*



Argument: [[action,passive,[ind,past,non_perfect,non_progressive,_8588],
[please,[regular,regular]],[[],[],[]]]]

Argument: [[action,passive,[ind,past,non_perfect,non_progressive,_42866],
[please,[regular,regular]],[[],[],[]]]]
quality
*/



printargs(Argument,X,Y,Z) :-
   write_nl(' error: printargs '),
   write('Argument: '),
   outl(Argument),
   outl(X),
   outl(Y),
   outl(Z).



