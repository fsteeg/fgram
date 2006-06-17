:- initialization ensure_loaded('expression_rules.pl').
:- initialization ensure_loaded('helpers.pl').
:- initialization ensure_loaded('lexicon.pl').

fg2 :-
   askForSubject(HeadOfSubject),
% 'noun' vorlaeufig als erstes Argument => bisher nur nominale Terme als Subjekte
   formTerm(noun,HeadOfSubject,subject,Restriction,Subject,Alist,Alist1,Q,Qt,I),
   chooseKind(Kind,HeadOfSubject,Predlist),
   choose_pred(Predlist,Predicate,Kind,Class,Forms,Args,Satellites),
   form_predication2(Predicate,Subject,Restriction,Class,Forms,Args,Satellites,Role,_,
                    Alist,Alist1,Qrole,Qterm,Illocution,finite,Raisability).

/* Intransitive Verbs */
form_predication2(Predicate,Subject,Restriction,Class,Forms,Args,
                 Satellites,Role,Noun,Alist,Alist3,Qrole,Qterm,Ill,Mode, Raisability) :-
   length(Args,1),
   write('You have chosen the verbal predicate '), write(Predicate), nl,
   write('Subject: '), write(Subject),nl,

   assignRoleToSyntacticFunction(_,Args,_,Role),
   determineVoice(Predicate,Role,Voice),

   modality(Mod,Predicate,noHeaderb),!,
   tense(Time,Perf,Prog,Predicate),!,
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
   Illocution = decl,
%   Voice = active,
   Predication = [Class,Voice,[Mod,Time,Perf,Prog,Num],[Predicate,Forms],[[],Subject,[],[],[]]],
   expression_rules(Illocution,mainclause,Predication,[wh],_Nlist,Punctuation),
   writep(Punctuation),nl.
   
   
   
/* Transitive Verbs */
form_predication2(Predicate,Subject,Restriction,Class,Forms,Args,
                 Satellites,SubjectRole,Noun,Alist,Alist3,Qrole,Qterm,Ill,Mode, Raisability) :-
   length(Args,2),
   write('You have chosen the verbal predicate '), write(Predicate), nl,
   write('Subject: '), write(Subject),nl,

   getNominalRestriction(Subject, RestrictionSubject),
   assignRoleToSyntacticFunction(Predicate,Args,subject,RestrictionSubject,SubjectRole),
   determineVoice(Predicate,SubjectRole,Role,Voice),
   askForNextArgument(Predicate, Role, Noun),
   formTerm(noun,Noun,Role,Restriction,Term,Alist,Alist1,Q,Qt,I),
   write('Vor placeTerm ...'), nl,
   placeTerm(Voice, Role, Restriction, Term, Object, Restargs, Satellites),
   write('placeTerm geschafft.'), nl,
   modality(Mod,Predicate,noHeaderb),!,
   tense(Time,Perf,Prog,Predicate),!,
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
   Illocution = decl,
%   Voice = active,
   Predication = [Class,Voice,[Mod,Time,Perf,Prog,Num],[Predicate,Forms],[[],Subject,Object,Restargs,Satellites]],
   expression_rules(Illocution,mainclause,Predication,[wh],_Nlist,Punctuation),
   writep(Punctuation),nl.


/* Ditransitive Verbs */
form_predication2(Predicate,Subject,Restriction,Class,Forms,Args,
                  Satellites,SubjectRole,Noun,Alist,Alist3,Qrole,Qterm,Ill,Mode, Raisability) :-
   length(Args,3),
   write('You have chosen the verbal predicate '), write(Predicate), nl,
   write('Subject: '), write(Subject),nl,

   /* First argument */
   assignRoleToSyntacticFunction(_,Predicate,Args,subject,SubjectRole),
   determineVoice(Predicate,SubjectRole,LexSeondRole,LexThirdRole,Voice),
   write('determineVoice geschafft. Voice: '), write(Voice), nl,

   /* Second argument */
   askForSecondRole(Voice, Predicate, LexSeondRole, LexThirdRole, SyntSecondRole, SyntThirdRole),
   write('secondRole done.'), nl,
   askForArgument(Predicate, SyntSecondRole, SyntSecondNoun),
   /* formTerm(noun, SyntSecondNoun, SyntSecondRole, SyntSecondRestriction, Object, Alist, Alist1, Q, Qt, I), */

   ( isPassive(Voice),
     /* If Voice = passive, the argument stored in SyntSecondRole/SyntSecondNoun is
        stored in Restargs to later realize it with preposition. If LexSeondRole
        was chosen as Subject, LexThirdRole = SyntSecondRole, if LexThirdRole was chosen
        as Subject, LexSeondRole = SyntThirdRole. */
     formTerm(noun, SyntSecondNoun, SyntSecondRole, SyntSecondRestriction, SyntSecondTerm, Alist, Alist1, Q, Qt, I),
     placeRestargs(SyntSecondRole, SyntSecondTerm, SyntSecondRestriction, Restargs)
   ;
     isActive(Voice),
     formTerm(noun, SyntSecondNoun, SyntSecondRole, SyntSecondRestriction, Object, Alist, Alist1, Q, Qt, I)
   ),

   /* Third argument */
   askForArgument(Predicate, SyntThirdRole, SyntThirdNoun),
   write('askForThirdRole (third argument): done'),nl,
   formTerm(noun,SyntThirdNoun, SyntThirdRole, SyntThirdRestriction, SyntThirdTerm, Alist, Alist1, Q, Qt, I),
   write('formTerm geschafft. Vor placeRestargs ...'),

   /* One of the arguments becomes Restarg ... */
   write('Vor placeTerm: '),
   placeTerm(Voice, SyntThirdRole, SyntThirdRestriction, SyntThirdTerm, Object, Restargs, Satellites),
   write('placeTerm done.'), nl,
   modality(Mod,Predicate,noHeaderb),!,
   tense(Time,Perf,Prog,Predicate),!,
   nl,write_nl('Underlying Predication (Logical Form): '),
   write('Predop: '),
   outl([Mod,Time,Perf,Prog]),
   Illocution = decl,
%   Voice = active,
   Predication = [Class,Voice,[Mod,Time,Perf,Prog,Num],[Predicate,Forms],[[],Subject,Object,Restargs,Satellites]],
   expression_rules(Illocution,mainclause,Predication,[wh],_Nlist,Punctuation),
   writep(Punctuation),nl.
   
   
/* In case of a transitive verb, if Voice is active, assign the object
   argument to Term, ...
   This predicate is DIFFERENTIATED from the other placeTerm-predicates
   by having two arguments less (Role and Restriction are missing because
   they are not necessary for Object). */
placeTerm(active, _Role, _Restriction, Term, Object,_Restargs, _Satellites):-
    Object = Term.

/* In case of ditransitive verbs, in the active case a term is only assigned
   to Restargs via the predicate placeTerm (the mechanism for Object-
   assignment is handled differently, see formPredication for ditransitive
   verbs). */
placeTerm(active, Role, Restriction, Term, _Object, Restargs, _Satellites):-
    Restargs = [[Role, Restriction, Term]].

/* ... if Voice is passive and agent = unexpressed, then assign the agent to Restargs. */
placeTerm(passive, _Role, _Restriction, [[],[],unexpressed,[],[],[],[]], Object, _Restargs, _Satellites) :-
    Object = [].
%    Restargs = [],
%    Satelittes = [].

/* ... if Voice is passive, assign the agent argument to
   satellites. */
placeTerm(passive, Role, Restriction, Term, Object,_Restargs, Satellites) :-
    Object = [],
    Satellites = [[Role, Restriction, Term]].

/* This predicate is only used to assign the second argument given
   during the procedure for ditransitives to Restargs. This assignment
   is independent of the second argument being the Goal, the Recipient
   or whatever. */
placeRestargs(Role, Term, Restriction, [[Role, Restriction, Term]]) :-
   write('placeRestargs done.'), nl.

   
   
   

printargs(Argument,X,Y,Z) :-
   write_nl(' error: printargs '),
   write('Argument: '),
   outl(Argument),
   outl(X),
   outl(Y),
   outl(Z).
   
   /******************************************************************************/
/*** Dialogue components ******************************************************/
/******************************************************************************/
askForSubject(HeadOfSubject):-
   write_nl('Which term do you want to talk about?'),
   write_nl('Choose from the following list, enter a proper noun or ask "wh".'),
   nounlist(Nlist),
   printlist(Nlist),
   read(HeadOfSubject).

askForNextArgument(Predicate, Role, Noun) :-
   write('Which term do you want as '), write(Role), write(' of '),
   write(Predicate), write('? '), nl,
   write_nl('Choose from the following list, enter a proper noun or ask "wh".'),
   nounlist(Nlist), printlist(Nlist),
   read(Noun).

/* askForAnotherArgument(Predicate, Function, Term) :-
   write('Which term do you want as '), write(Function), write(' of '),
   write(Predicate), write('? '), nl,
   write_nl('Choose from the following list, enter a proper noun or ask "wh".'),
   nounlist(Nlist), printlist(Nlist),
   read(Term). */

/* If Role2 of the three-place predicate is the object, Role3 has to
   be assigned to ThirdRole; otherwise, Role2 has to be assignet to
   ThirdRole. */
askForSecondRole(active, Predicate, Role2, Role3, ObjectRole, ThirdRole) :-
   write('Which role do you want as object of '), write(Predicate), write('?'), nl,
   write('Choose '), write(Role2), write(' or '), write(Role3), nl,
   read(ObjectRole),
   write('read(ObjectRole) done.'),
   determineThirdRole(Role2, Role3, ObjectRole, ThirdRole).

/* In the case of passive, the order of requested arguments is fixed: As the
   second argument, the recipient must be given, as the third argument
   the agent. */
askForSecondRole(passive, Predicate, RestargsRole, agent, RestargsRole, agent).
askForSecondRole(passive, Predicate, agent, RestargsRole, RestargsRole, agent).


/* With respect to the third argument of determineThirdRole (ObjectRole), the
   NonObjectRole is assigned. */
determineThirdRole(ObjectRole, NonObjectRole, ObjectRole, NonObjectRole).
determineThirdRole(NonObjectRole, ObjectRole, ObjectRole, NonObjectRole).

askForArgument(Predicate, ArgumentRole, ArgumentNoun) :-
   write('Which term do you want as'), tab(1), write(ArgumentRole), tab(1), write('of'), tab(1),
   write(Predicate), write('? '), nl,
   write_nl('Choose from the following list, enter a proper noun or ask "wh".'),
   nounlist(Nlist), printlist(Nlist),
   read(ArgumentNoun).

/* Third argument */
/*askForThirdRole(Predicate, ThirdRole, ThirdNoun) :-
   write('Which term do you want as'), tab(1), write(ThirdRole), tab(1), write('of'), tab(1),
   write(Predicate), write('?'), nl,
   write_nl('Choose from the following list, enter a proper noun or ask "wh".'),
   nounlist(Nlist), printlist(Nlist),
   read(ThirdNoun).*/

readDet(Det) :-
   write_nl(' def,indef,total,prox,nprox,neg,qdef,or qindef?'),
   read(Det).

readNumber(Number):-
   write_nl('Is number sing or plural?'),
   read(Number).

chooseKind(Kind,Word,Predlist) :-
   write('What kind of predicate do you want for the chosen subject "'),
   write(Word), write_nl('"?'),
   write_nl('verb, noun or adj(ective)?'),
   read(Kind),
   suffix(Kind,list,Klist),
   PROGRAM=..[Klist,Predlist], call(PROGRAM).

choose_pred(Predlist,Word,Kind,Class,Forms,Args,Satellites) :-
   write_nl('Choose a predicate from following list:'),
   printlist(Predlist),
   read(Word),
   PROGRAM=..[Kind,Word,Class,Forms,Args,Satellites], call(PROGRAM),
/*   get(Kind,Word,Class,Fs,Args,Satellites), */
   write('Forms: '),write(Forms),nl.

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
   
   
   /******************************************************************************/
/*** Argument insertion *******************************************************/
/******************************************************************************/
argument_insertion(Word,[],X,Y,A,A,Q,T,I,M,R).

argument_insertion(Word,[[Role,Restriction,Term]|Tailargs],Args1,Nounlist,Alist,
   Alist2,Qrole,Qterm,Ill,Mode,R) :-
   write('entered arg_ins Restriction: '),write(Restriction),lines(2),
   write('Alist2 in arg_ins vor askterm = '), write(Alist2),nl,
   askterm(Word,Role,Restriction,Args1,Term,Nounlist,Alist,Alist1,Qrole,Qterm,Ill,Mode,R),
   write('Alist2 in arg_ins nach askterm = '), write(Alist2),nl,
   argument_insertion(Word,Tailargs,Args1,Nounlist,Alist1,Alist2,Qrole,Qterm, Ill,Mode,R).


/*********************************************************************************/

/******************************************************************************/
/*** Determining Voice ********************************************************/
/******************************************************************************/
determineVoice(Word,argument,passive) :- !.

determineVoice(Verb,SubjectRole,Role2,Voice) :-
   verb(Verb,C,_,[[FirstRole,_,_],[SecondRole,_,_]|_],_),write('vor voice'),nl,
   write(SubjectRole),write(' '),write(FirstRole),nl,
   voice(SubjectRole,FirstRole,Voice),
   determineObjectRole(Voice, FirstRole, SecondRole, Role2).

determineVoice(Verb,SubjectRole,Role2,Role3,Voice) :-
   verb(Verb,C,_,[[FirstRole,_,_],[SecondRole,_,_],[ThirdRole,_,_]|_],_),write('vor voice'),nl,
   write(SubjectRole),write(' '),write(FirstRole),nl,
   voice(SubjectRole,FirstRole,Voice),
   determineRestRoles(Voice, FirstRole, SecondRole, ThirdRole, SubjectRole, Role2, Role3).

voice(Role,FirstArg,active) :-
   eq(Role,FirstArg),
   !.

voice(_,_,passive).

/* In the ditransitive case, assign the remaining roles. */
determineRestRoles(active, _, SecondRole, ThirdRole, _, SecondRole, ThirdRole).
determineRestRoles(passive, FirstArg, SecondArg, ThirdArg, SecondArg, FirstArg, ThirdArg).
determineRestRoles(passive, FirstArg, SecondArg, ThirdArg, ThirdArg, FirstArg, SecondArg).

/* If active, assign the role for second argument to Role2, ...*/
determineObjectRole(active, _FirstRole, SecondRole, SecondRole).
/* ... if passive, assign the first role to Role2. */
determineObjectRole(passive, FirstRole, _SecondRole, FirstRole).


/******************************************************************************/
/*** Function assignment ******************************************************/
/******************************************************************************/

/* Retrieve the sole Role for an intransitive verb from the
   lexicon. Only intransitive verbs use this version because of
   the single element list in the second argument. */
assignRoleToSyntacticFunction(_,[[Role,_,_]],_,Role).

/* Determining role for subject: if noun is animate and first arg of verb is
   animate, then, if second arg of verb is NOT animate, the subject receives
   the first role of the verb. */
assignRoleToSyntacticFunction(Word,[[Role1,animate,_],[_, Restr2,_]],subject, RestrS, Role1) :-
   ( eq(RestrS,animate);
     eq(RestrS,human)     ),
   noteq(Restr2,animate).

assignRoleToSyntacticFunction(Word,[[Role1,human,_],[_,Restr2,_]],subject, human, Role1) :-
   noteq(Restr2,human).

/* This is the 'transitive' version of assignRole...; it is used, if
   two roles are left over in the list. */
assignRoleToSyntacticFunction(Word,[[Role1,_,_],[Role2,_,_]],Function,Restriction,Role) :-
   write('Which term is '),
   write(Function),
   write(' of '),
   printquote(Word),
   questionmark,
   write_nl('Choose semantic role of term from following:'),
   write('    '), write(Role1), write(', '), write(Role2), nl,
   read(Role).

assignRoleToSyntacticFunction(active,Word,[[Role1,_,_],[Role2,_,_],[Role3,_,_]],Function,Role) :-
   write('Which term is '),
   write(Function),
   write(' of '),
   printquote(Word),
   questionmark,
   write_nl('Choose semantic role of term from following:'),
   write('    '), write(Role1), write(', '), write(Role2), write(' or '), write(Role3), nl,
   read(Role).

assignRoleToSyntacticFunction(active,Word,[[Role2,_,_],[Role3,_,_]],Function,Role) :-
   write('Debugging assignRole ...'),
   write('Which term is '),
   write(Function),
   write(' of '),
   printquote(Word),
   questionmark,
   write_nl('Choose semantic role of term from following:'),
   write('    '), write(Role2), write(' or '), write(Role3), nl,
   read(Role).

assignRoleToSyntacticFunction(passive, _, _, _, _).

/* assignSubject(active,Word,[[subject,any,Subject]|Args2],Theme,Subject,
   Args2,R,Sat,Sat1,Role1,[P,Termop,Noun,GramInfo,Modif,Rphr,[]]). */

/* Determines subject and object for transitive verbs.
so_assignment(Voice,Word,Args,Theme,Subject,Object,Restargs,Sat,Sat1,Qrole,Qterm) :-
   check_subject(Voice,Args,Args1),
   subject_assignment(Voice,Word,Args1,Theme,Subject,Args2,Restargs,Sat,
   Sat1,Qrole,[mainclause,Termop,Noun,GramInfo,Modif,Rphr,[]]),!,
   write('nach subj.-ass mainclause:'),nl,write('Voice: '),
   write(Voice),nl,write('Args2: '),write(Args2),nl,
   object_assignment(Voice,Word,Args2,Args3,Theme,Object,Restargs),!,
   write('nach obj.-ass mainclause:'),nl,write('Voice: '),
   write(Voice),nl,write('Object: '),write(Object),nl.   */

check_subject(passive,[[Role,Restr,[[],[],unexpressed,[],[],[],[]]]|Tailargs],Tailargs).
check_subject(Voice,Args,Args).

/* This predicate extracts the restriction out of a formed term and returns
   it to the second argument. */
getNominalRestriction([_,_,_,[Restriction|_]|_], Restriction).








