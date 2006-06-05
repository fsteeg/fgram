:- initialization ensure_loaded('generated_ucs.pl').
%:- initialization ensure_loaded('working_ucs.pl').
%:- initialization ensure_loaded('underly.pl').
expression(Res) :-
	consult('src-prolog/generated_ucs.pl'),
%	consult('generated_ucs.pl'),
	retractall(expression_result(_)),
    node(StartNode, 0),
    formStructureFromNode(StartNode, Predication),
    nl, nl, write('Predication: '), write(Predication), nl, nl,
    readProp(clause, illocution, Illocution),
    readProp(clause, type, ClauseType),
    expression_rules(Illocution, ClauseType, Predication, [wh], _Nlistout, '.'),
    append("ucs ", "okay", Res).
    	
nonDeterministicGoal(InterestingVarsTerm,G,ListTM) :-
  findall(InterestingVarsTerm,G,L), buildTermModel(L,ListTM).

% Two types of formal structure within a predicate are differentiated:
%     - Predicates (short: pred)
%     - Terms (short: term)
%   For any type of formal structure, a different predicate is provided.

% This predicate forms Terms. 
% TODO: Formation of complex terms with relative clauses etc. 
formStructureFromNode(Node, Term) :-
    readProp(Node, type, term), % Check for term-hood
    node(Node, Level),          % The level in the pred-arg hierarchy
    readProp(Node, lex, Lex),
    readProp(Node, role, Role),
    readProp(Node, relation, Relation),
    readProp(Node, proper, Proper),
    readProp(Node, det, Det),
    readProp(Node, num, Num),
    readProp(Node, modifs, Modifs),
    /* Should be changed by time because only expression_rules should
       be used from the old program. */
    formTerm(noun, Det, Num, Lex, Role, Modifs, Term, Alist, Alist3, Q, Qt, Ill).

% This predicate forms Predications. The list in the secaond argument
%   represents the actual predication.
formStructureFromNode(Node, [Class, Voice, [Mode, Tense, Perfect, Progressive, Number], [Verb, VerbForms], ArgumentList] ) :-
    % Check for pred-hood
    readProp(Node, type, pred),
    % The level in the pred-arg hierarchy
    node(Node, Level),
    readProp(Node, lex, Verb),
    % Retrieve information from lexicon entry
    verb(Verb, Class, VerbForms, _, _),
    readProp(Node, tense, Tense),
    readProp(Node, perfect, Perfect),
    readProp(Node, progressive, Progressive),
    readProp(Node, mode, Mode),
    readProp(Node, voice, Voice),
    readProp(Node, subnodes, Subnodes),
    /* The ArgumentList contains the list [Theme, Subject, Object, RestArgs, Satellites]. */
    initializeSubnodes(Subnodes, ArgumentList).

initializeSubnodes([], _).
initializeSubnodes([ActNode|RestNodes], [Theme, Subject, Object, RestArgs, Satellites]) :-
    initializeSubnode(ActNode, [Theme, Subject, Object, RestArgs, Satellites]),
    initializeSubnodes(RestNodes, [Theme, Subject, Object, RestArgs, Satellites]).

initializeSubnode(ActNode, [Theme, _Subject, _Object, _RestArgs, _Satellites]) :-
    % Is ActNode the Theme of the sentence?
    readProp(ActNode, pragmatic, theme),
    % Then: Form the respective structure and store it in Theme.
    formStructureFromNode(ActNode, Theme).

initializeSubnode(ActNode, [_Theme, Subject, _Object, _RestArgs, _Satellites]) :-
    % Is ActNode the (non-Theme) subject of the sentence?
    readProp(ActNode, relation, subject),
    % Then: Form the respective structure and store it in Subject.
    formStructureFromNode(ActNode, Subject).

initializeSubnode(ActNode, [_Theme, _Subject, Object, _RestArgs, _Satellites]) :-
    % Is ActNode the (non-Theme) Object of the sentence?
    readProp(ActNode, relation, object),
    % Then: Form the respective structure and store it in Object.
    formStructureFromNode(ActNode, Object).

% readProp encapsulates the access to the prop-entries because
% some of the entries need to be transformed during retrieval.
readProp(Node, PropType, Value) :-
    prop(Node, PropType, Value1),
    convertValue(PropType, Value1, Value).

% Translates standard values into idiosyncratic values.
% that are needed for the correct predicate calls.
convertValue(_, null, []).
convertValue(perfect, true, perfect).
convertValue(perfect, false, non_perfect).
convertValue(progressive, true, progressive).
convertValue(progressive, false, non_progressive).
convertValue(_, true, yes).
convertValue(_, false, no).
convertValue(_, Value, Value).


test_ex_rules :-
    expression_rules(
        decl,
    mainclause,
    [action,active,
        [ind,past,non_perfect, non_progressive,_],
            [kill,[regular,regular]],
            [
                [],
                [_,[indef,sing],farmer,[human,regular,masc],[],[],[]],
                [_,[total,sing],duckling,[animate,regular,neuter], [], [],[]],
                [],
                []
            ]
        ],
        [wh],
        _,
        _Punctuation).


/**************************************************************************/
/**************************************************************************/
/** Modified expression rules *********************************************/
/**************************************************************************/
/**************************************************************************/

mod_print_np(Kind,[T,Num],Modif,Noun,GramInfo,Case,Clause,Nlist,Nlist,Cap) :-
   member(Noun,Nlist), !, eq(GramInfo,[_,_,Gender]), pronouns(Pronouns),
member([Pronoun,Kind,Gender,Num,Case],Pronouns),
printc(Cap,Clause,Pronoun).

mod_print_np(P,[[],sing],[],ProperNoun,GramInfo,Case,Clause,Nlist,Nlist1,
   Cap) :-
   !,
   add_member(ProperNoun,Nlist,Nlist1),
   capitalize(ProperNoun,Pnoun),
   printb(Pnoun).

test_print_np :-
    GramInfo = [_, regular, _],
    mod_print_np(_, [def, sing], ['nice', 'little'], duckling, GramInfo).

mod_print_np(P,[Det,Num],Modif,Noun,GramInfo) :-
   !,
   determiner(Detlist),
   member([Determiner,Det,Num,Gender],Detlist),
   eq(GramInfo,[_,Plural,_]),
   printcm(Determiner,Modif,Noun,Num,Plural).


/**************************************************************************/
/**************************************************************************/
/** Original expression rules *********************************************/
/**************************************************************************/
/**************************************************************************/

/* AUSDRUCKREGELN */

expression_rules(i,C,[],Nlist,Nlist,p).

expression_rules(decl,mainclause,[quality,passive,[Mod,Time,Perf,Prog,Num],
   [Verb,Vbforms],[Theme,[],Obj,Restargs,Satellites]],Nlist,Nlistout, '.') :-
   printtheme(Theme,Nlist,Nlist1,Clause,Cap,Cap1),
   write(' It'),
   printverb(quality,passive,Mod,Time,Perf,Prog,sing,Verb,Vbforms,[],
   Nlist1,Nlist2),
   printterm(Subj,Case,Clause,Nlist2,Nlist3,no),
   printObjArgs(Obj,Restargs,Satellites,Class,Nlist3,Nlistout).

expression_rules(decl,Clause,[Class,Voice,[Mod,Time,Perf,Prog,Num],[Verb,
   Vbforms],[Theme,Subj,Obj,Restargs,Satellites]],Nlist,Nlistout,'.') :-
   nl,write('Clause: '),write(Clause),
   nl, write('Class: '), write(Class),
   nl, write('Voice: '), write(Voice),
   nl, write('  Mode: '), write(Mod),
   nl, write('  Time: '), write(Time),
   nl, write('  Perf: '), write(Perf),
   nl, write('  Prog: '), write(Prog),
   nl, write('  Num: '), write(Num),
   nl, write('Verb: '), write(Verb),
   nl, write('Vbforms: '), write(Vbforms),
   nl,write('Theme: '), write(Theme),nl,write('Subj: '),write(Subj),nl,
   write('Obj: '),write(Obj),nl,write('Restargs: '), write(Restargs),nl,
   write('Nlist:'),write(Nlist),lines(2),
   printtheme(Theme,Nlist,Nlist1,Clause,Cap,Cap1),
   printsubject(Subj,Nlist1,Nlist2,Clause,Cap1), ! ,
   insert_number(Subj,Verb,Num),
   printverb(Class,Voice,Mod,Time,Perf,Prog,Num,Verb,Vbforms,[],Nlist2,
   Nlist3),
   printObjArgs(Obj,Restargs,Satellites,Class,Nlist3,Nlistout).

expression_rules(Ill,relclause,[Class,Voice,[Mod,Time,Perf,Prog,Num],[Verb,
   Vbforms],[Theme,Subj,Obj,Restargs,Satellites]],Nlist,Nlistout,'.') :-
%   nl,write('Clause: '),write(Clause),
%   nl,write('Theme: '), write(Theme),nl,write('Subj: '),write(Subj),nl,
%   write('Obj: '),write(Obj),write('Restargs: '), write(Restargs),nl,
%   write('Nlist:'),write(Nlist),lines(2),
   printtheme(Theme,Nlist,Nlist1,Clause,Cap,Cap1),
   printsubject(Subj,Nlist1,Nlist2,Clause,Cap1), ! ,
   insert_number(Subj,Verb,Num),
   printverb(Class,Voice,Mod,Time,Perf,Prog,Num,Verb,Vbforms,[],Nlist2,
   Nlist3),
   printObjArgs(Obj,Restargs,Satellites,Class,Nlist3,Nlistout).

expression_rules(question,Clause,[Class,Vce,[Mod,Time,Perf,Prog,Num],[
   Verb,Vbforms],[Theme,Subj,Obj,Restargs,Satellites]],Nlist,Nlistout,
   '?') :-
   eq(Theme,[]),
   printsubject(Subj,Nlist,Nlist1,Clause,capitalize),!,
   insert_number(Subj,Verb,Num),
   printverb(Class,Vce,Mod,Time,Perf,Prog,Num,Verb,Vbforms,[],Nlist1,
   Nlist2),
   printObjArgs(Obj,Restargs,Satellites,Class,Nlist2,Nlistout).

expression_rules(question,Clause,[Class,Vce,[Mod,Time,Perf,Prog,Num],[
   Verb,Vbforms],[Theme,Subj,Obj,Restargs,Satellites]],Nlist,Nlistout,
   '?') :-
   printtheme(Theme,Nlist,Nlist1,Clause,capitalize,no),
   insert_number(Subj,Verb,Num),
   printverb(Class,Vce,Mod,Time,Perf,Prog,Num,Verb,Vbforms,Subj,
   Nlist1,Nlist2),
   printObjArgs(Obj,Restargs,Satellites,Class,Nlist2,Nlistout).

expression_rules(_,relclause,[Inf|Tail],Nlist,Nlistout,Punctuation) :-
   printargs([Inf|Tail],Class,Nlist,Nlistout).


/* ============================================================== */

/* GRAMMATICON */

be([[was,past,sing],[were,past,plural],[is,present,sing],[are,present,plural]]).

have([[had,past,N],[has,present,sing],[have,present,plural]]).

do([[did,past,N],[does,present,sing],[do,present,plural]]).

determiner([["the",def,N,G],["a",indef,sing,G],["",indef,plural,G],["every",total
   ,sing,G],["all",total,plural,G],["this",prox,sing,G],["these",prox,plural,G],
   ["that",nprox,sing,G],["those",nprox,plural,G],["no",neg,N,G],["which",qdef,n
   ,G],["what kind of",qindef,N,G],["how much",qquantity,sing,G],["how many",
   qquantity,plural,G]]).

pronouns([[he,pers,masc,sing,subj],[him,pers,masc,sing,ob],[she,pers,fem,sing,subj],
   [her,pers,fem,sing,ob],[it,pers,neuter,sing,C],[they,pers,G,plural,subj],[them,
   pers,G,plural,ob],[what,question,neuter,N,C],[that,rel,neuter,N,subj],[which,rel
   ,neuter,N,ob],[who,K,G,N,subj],[whom,K,G,N,ob]]).


/* PREPOSITIONS */

agent(Term,action,Nlist,Nlist1,C,Cap) :-
   printc(Cap,C,by),
   printterm(Term,ob,C,Nlist,Nlist1,no).

beneficiary(Term,Class,Nlist,Nlist1,C,Cap) :-
   printc(Cap,C,for),
   printterm(Term,ob,C,Nlist,Nlist1,no).

direction(Term,Class,Nlist,Nlist1,C,Cap) :-
   printc(Cap,C,to),
   printterm(Term,ob,C,Nlist,Nlist1,no).

experiencer(Term,state,Nlist,Nlist1,C,Cap) :-
   printc(Cap,C,by),
   printterm(Term,ob,C,Nlist,Nlist1,no).

experiencer(Term,action,Nlist,Nlist1,C,Cap) :-
   printc(Cap,C,to),
   printterm(Term,ob,C,Nlist,Nlist1,no).


goal(Term,Class,Nlist,Nlist1,C,Cap) :-
   printterm(Term,ob,C,Nlist,Nlist1,Cap).

instrument(Term,Class,Nlist,Nlist1,C,Cap) :-
   printc(Cap,C,with),
   printterm(Term,ob,C,Nlist,Nlist1,no).

loc_in(Term,Class,Nlist,Nlist1,C,Cap) :-
   printc(Cap,C,in),
   printterm(Term,ob,C,Nlist,Nlist1,no).

loc_on(Term,Class,Nlist,Nlist1,C,Cap) :-
   printc(Cap,C,on),
   printterm(Term,ob,C,Nlist,Nlist1,no).

manner(Term,Class,Nlist,Nlist1,C,Cap) :-
   printc(Cap,C,like),
   printterm(Term,ob,C,Nlist,Nlist1,no).

purpose(Infinitive,Class,Nlist,Nlist1,C,Cap) :-
   printc(Cap,C,in),
   write(' order'),
   printterm(Infinitive,Case,Clause,Nlist,Nlist1,no).

reason(Predication,Class,Nlist,Nlist1,C,Cap) :-
   printc(Cap,C,because),
   expression_rules(Ill,subclause,Predication,Nlist,Nlist1,'.').

recipient(Term,Class,Nlist,Nlist1,C,Cap) :-
   printc(Cap,C,to),
   printterm(Term,ob,C,Nlist,Nlist1,no).


second_argument(Term,Class,Nlist,Nlist1,C,Cap) :-
   printterm(Term,ob,C,Nlist,Nlist1,Cap).

time_point(Term,Class,Nlist,Nlist1,C,Cap) :-
   printc(Cap,C,on),
   printterm(Term,ob,C,Nlist,Nlist1,no).

time_space(Term,Class,Nlist,Nlist1,C,Cap) :-
   printc(Cap,C,during),
   printterm(Term,ob,C,Nlist,Nlist1,no).

/* ============================================================== */

/* AUSDRUCKEN */

printObjArgs(Obj,Restargs,Satellites,Class,Nlist,Nlistout) :-
   printterm(Obj,ob,Clause,Nlist,Nlist1,no),
   printargs(Restargs,Class,Nlist1,Nlist2),
   printargs(Satellites,Class,Nlist2,Nlistout).

printtheme([],Nlist,Nlist,C,Cap,capitalize) :- !.

printtheme([Role,Term],Nlist,Nlist1,Clause,Cap,no) :-
PROGRAM=..[Role,Term,Class,Nlist,Nlist1,Clause,Cap], call(PROGRAM).

printtheme([rel,Termop,Noun,GramInfo,Modif,_,[]],Nlist,Nlist1,Clause,Cap,no):-
      print_np(rel,Termop,Modif,Noun,GramInfo,Case,Clause,Nlist,Nlist1,no).

printsubject([question,[[],sing],wh,GramInfo,[],[],[]],Nlist,Nlist,
              Clause,capitalize) :-
%    nl,write('Subject of Question: Graminfo: '),write(Graminfo),
%    write(' Clause: '),write(Clause),nl,
   printterm([question,[[],sing],wh,GramInfo,[],[],[]],subj,Clause,Nlist,
   Nlist,capitalize).


printsubject([P,Termop,Noun,GramInfo,Modif,Relphr,Rel],Nlist,Nlist1,
   Clause,Cap) :-
   printterm([P,Termop,Noun,GramInfo,Modif,Relphr,Rel],subj,Clause,Nlist,
   Nlist1,Cap).

printsubject(Predication,Nlist,Nlist1,Clause,capitalize) :-
   printterm(Predication,subj,Clause,Nlist,Nlist1,capitalize).

insert_number(Subj,Pred,Num) :-
   get_number(Subj,Num),
   % nl, write('Number of verb form: '), write(Num), nl,
   check_nompred(Pred,Num).

check_nompred([predicate,[D,Num],N,Gi,M,R],Num).

check_nompred(_Pred,_Num).

get_number([P,[Det,Number],Noun,GramInfo,Modif,Rel],Number).

get_number(Proposition,sing).

printterm([[],[],unexpressed,[],[],[],[]],C,Cl,Nl,Nl,Cap).

printterm([],subj,mainclause,Nlist,Nlist,capitalize) :-
   write(' It').

printterm([],Case,Clause,Nlist,Nlist,Cap).

printterm([Class,Vce,Verbop,V,[[],Subject,Object,Restargs,Stellites]],
   Case,Clause,Nlist,Nlistout,Cap) :-
   printc(Cap,Clause,that),
   !,
   expression_rules(K,subclause,[Class,Vce,Verbop,V,[Theme,Subject,Object,
   Restargs,Stellites]],Nlist,Nlistout,P).

printterm([Class,Vce,[Mod,Time,Perf,Prog,Num],[Verb,[Form2,Form3]],[
   Obj,Restargs,Satellites]],Case,Clause,Nlist,Nlistout,Cap) :-
   printc(Cap,Clause,to),
   printinfinitive(Vce,Time,Perf,Prog,Verb,Form3,Nlist,Nlist1),
   printObjArgs(Obj,Restargs,Satellites,Class,Nlist1,Nlistout).

printterm([Term,Restargs,Satellites],Case,Clause,Nlist,Nlistout,Cap) :-
   printterm(Term,Case,C,Nlist,Nlist1,Cap),
   printargs(Restargs,Class,Nlist1,Nlist2),
   printargs(Satellites,Class,Nlist2,Nlistout).

printterm([predicate,Termop,Noun,GramInfo,Modif,[Inf]],Case,Clause,
   Nlist,Nlist2,Cap) :-
   print_np(P,Termop,Modif,Noun,GramInfo,Case,Clause,Nlist,Nlist1,Cap),
   printterm(Inf,Case,Clause,Nlist1,Nlist2,no).

printterm([relative,Termop,Noun,GramInfo,Modif,Rphr/*,Rel*/],Case,Clause,Nlist,
   Nlist3,Cap) :-
   !,
   print_np(rel,Termop,Modif,Noun,GramInfo,Case,Clause,Nlist,Nlist1,Cap),
   print_relphr(Rphr,Nlist1,Nlist2),
   expression_rules(I,relclause,Rel,Nlist2,Nlist3,Punctuation).

printterm([P,Termop,Noun,GramInfo,Modif,Rphr,Rel],Case,Clause,Nlist,
   Nlist3,Cap) :-
   !,
   print_np(P,Termop,Modif,Noun,GramInfo,Case,Clause,Nlist,Nlist1,Cap),
   print_relphr(Rphr,Nlist1,Nlist2),
   expression_rules(I,relclause,Rel,Nlist2,Nlist3,Punctuation).

print_relphr([],Nlist,Nlist).

print_relphr([P,Termop,Noun,GramInfo,Modif,Rphr,Rel],Nlist,Nlist1) :-
   write(' of'),
   printterm([P,Termop,Noun,GramInfo,Modif,[],Rel],Case,Clause,Nlist,
   Nlist3,no).

print_np(Kind,[T,Num],Modif,Noun,GramInfo,Case,Clause,Nlist,Nlist,Cap) :-
   member(Noun,Nlist),
   !,
   eq(GramInfo,[_,_,Gender]),
   pronouns(Pronouns),
   member([Pronoun,Kind,Gender,Num,Case],Pronouns),
   printc(Cap,Clause,Pronoun).

print_np(P,[[],sing],[],ProperNoun,GramInfo,Case,Clause,Nlist,Nlist1,
   Cap) :-
   !,
   add_member(ProperNoun,Nlist,Nlist1),
   capitalize(ProperNoun,Pnoun),
   printb(Pnoun).

print_np(P,[Det,Num],Modif,Noun,GramInfo,Case,Clause,Nlist,Nlist1,Cap) :-
   !,
   add_member(Noun,Nlist,Nlist1),
   determiner(Detlist),
   member([Determiner,Det,Num,Gender],Detlist),
   eq(GramInfo,[_,Plural,_]),
   printcm(Cap,Clause,Determiner,Modif,Noun,Num,Plural).

plural(Verb) :-
   printb(Verb).

plural(Cap,Clause,[],Noun,regular) :-
   !,
   suffix(Noun,s,Plural),
   printc(Cap,Clause,Plural).

plural(Cap,Clause,[],Noun,Plural) :-
   printc(Cap,Clause,Plural).

plural(Cap,Clause,Modif,Noun,regular) :-
   !,
   writelistc(Cap,Clause,Modif),
   suffix(Noun,s,Plural),
   printbm(Plural).

plural(Cap,Clause,Modif,Noun,Plural) :-
   writelistc(Cap,Clause,Modif),
   printb(Plural).

sing(have) :-
   printb(' has').

sing(Verb) :-
    append_letter(Verb, s, InflVerb),
    printb(InflVerb).

sing(C,"a",[],Noun,P) :-
   firstletter(L,Noun),
   member(L,[a,e,i,o,u]),
   !,
   printb(n),
   printb(Noun).

sing(C,"a",[Head|Tail],Noun,P) :-
   firstletter(L,Head),
   member(L,['a','e','i','o','u']),
   !,
   printb('n'),
   writelist([Head|Tail]),
   printb(Noun).

sing(C,D,[],Noun,P) :-
   !,
   printb(Noun).

%%%
sing(C,D,Modif,Noun,P) :-
   writelist(Modif),
   printb(Noun).

argument(Infinitive,Class,Nlist,Nlist1,C,Cap) :-
   printterm(Infinitive,Case,Clause,Nlist,Nlist1,no).

printverb(Class,Voice,Mod,Time,Perf,Prog,Number,Verb,Verbforms,Subj,
   Nlist,Nlist1) :-
   PROGRAM=..[Mod,Voice,Time,Perf,Prog,Number,Verb,Verbforms,Subj,Nlist,Nlist1], call(PROGRAM).

printinfinitive(Voice,Time,Perf,Prog,Verb,Form3,Nlist,Nlist1) :-
   PROGRAM=..[Time,Voice,Perf,Prog,Verb,Form3,Nlist,Nlist1,inf], call(PROGRAM).

ind(Voice,Time,Perf,Prog,Num,Verb,[Form2,Form3],Subj,Nlist,
   Nlist1) :-
   PROGRAM=..[Voice,Perf,Prog,Time,Num,Verb,[Form2,Form3],Subj,Nlist,Nlist1], call(PROGRAM).

future(Voice,Time,Perf,Prog,Num,Verb,[F2,Form3],Subj,Nlist,Nlist2) :-
   printmod(will,would,Time),
   printterm(Subj,Case,Clause,Nlist,Nlist1,no),
   PROGRAM=..[Perf,Prog,Voice,Verb,Form3,Nlist1,Nlist2], call(PROGRAM).

possibility(Voice,Time,Perf,Prog,Num,Verb,[F2,Form3],Subj,Nlist,Nlist2 ) :-
   printmod(may,might,Time),
   printterm(Subj,Case,Clause,Nlist,Nlist1,no),
   PROGRAM=..[Perf,Prog,Voice,Verb,Form3,Nlist1,Nlist2], call(PROGRAM).

potentiality(Voice,Time,Perf,Prog,Num,Verb,[F2,Form3],Subj,Nlist, Nlist2) :-
   printmod(can,could,Time),
   printterm(Subj,Case,Clause,Nlist,Nlist1,no),
   PROGRAM=..[Perf,Prog,Voice,Verb,Form3,Nlist1,Nlist2], call(PROGRAM).

necessity(Voice,Time,Perf,Prog,Num,Verb,[F2,Form3],Subj,Nlist,Nlist2) :-
   printmod(must,must,Time),
   printterm(Subj,Case,Clause,Nlist,Nlist1,no),
   PROGRAM=..[Perf,Prog,Voice,Verb,Form3,Nlist1,Nlist2], call(PROGRAM).

printmod(Present,Past,present) :-
   printb(Present).

printmod(Present,Past,past) :-
   printb(Past).

/* ============================================================== */

/* Aktiv / Passiv  */

active(Args2,Restargs).

active(Args2,Restargs,Sat,Sat):-
   is_list(Args2).

active(Verb,Form3,N,n,perf) :-
   form3(Verb,Form3,N,N).

active(Verb,Form3,N,N) :-
   printb(Verb).

active(Verb,X,N,n,prog) :-
   printprog(Verb,X).

active(Perf,Prog,Time,Number,Verb,Verbforms,Subj,N,N1) :-
   PROGRAM=..[Perf,Prog,Time,Number,Verb,Verbforms,Subj,N,N1], call(PROGRAM).



passive(Term,noun,Nlist,Nlist1,perf) :-
   printb(been),
   printterm(Term,Case,Clause,Nlist,Nlist1,no).

passive(Pred,Form3,N,n,perf) :-
   printb(been),
   form3(Pred,Form3,N,N).

/* die n�chsten drei Klauseln sind aus underlying pred. */

passive(Restargs,Restargs).

passive([],Restargs,Sat,Sat).

passive([Head|Tail],Tail,Sat,[Head|Sat]).


passive(Pred,Form3,Nlist,Nlist1) :-
   printb(be),
   form3(Pred,Form3,Nlist,Nlist1).

passive(Pred,Form3,Nlist,Nlist1,prog) :-
   write(' in the process of being'),
   form3(Pred,Form3,Nlist,Nlist1).

passive(Perf,Prog,Time,Number,Verb,[Form2,Form3],Subj,N,N1) :-
   PROGRAM=..[Perf,Prog,Time,Number,Verb,Form3,Subj,N,N1], call(PROGRAM).

/* ============================================================== */


non_perfect(Prog,Time,Number,Verb,[Form2,Form3],Subj,N,N1) :-
   PROGRAM=..[Prog,Time,Number,Verb,[Form2,Form3],Subj,N,N1], call(PROGRAM).

non_perfect(Prog,Time,Number,Pred,Form3,Subj,Nlist,Nlist2) :-
   aux(be,Time,Number),
   printterm(Subj,Case,Clause,Nlist,Nlist1,no),
   PROGRAM=..[Prog,Pred,Form3,Nlist1,Nlist2], call(PROGRAM).

non_perfect(Prog,Voice,Verb,Form3,Nlist,Nlist1) :-
   PROGRAM=..[Prog,Voice,Verb,Form3,Nlist,Nlist1], call(PROGRAM).

perfect(Prog,Time,Number,Verb,[Form2,Form3],Subj,Nlist,Nlist1) :-
   aux(have,Time,Number),
   printterm(Subj,Case,Clause,Nlist,Nlist1,no),
   PROGRAM=..[Prog,Verb,Form3,perf], call(PROGRAM).
perfect(Prog,Time,Number,Pred,Form3,Subj,Nlist,Nlist2) :-
   aux(have,Time,Number),
   printterm(Subj,Case,Clause,Nlist,Nlist1,no),
   printb(been),
   form3(Pred,Form3,Nlist1,Nlist2).
perfect(Prog,Voice,Verb,Form3,Nlist,Nlist1) :-
   printb(have),
   PROGRAM=..[Prog,Voice,Verb,Form3,Nlist,Nlist1,perf], call(PROGRAM).

non_progressive(Time,Number,Verb,[Form2,Form3],[],N,N1) :-
   PROGRAM=..[Time,Number,Verb,Form2,N,N1], call(PROGRAM).
non_progressive(Time,Number,Verb,[Form2,Form3],Subj,Nlist,Nlist1) :-
   aux(do,Time,Number),
   printterm(Subj,Case,Clause,Nlist,Nlist1,no),
   printb(Verb).
non_progressive(Verb,Form3,perf) :-
   form3(Verb,Form3,N,N).
non_progressive(Voice,Verb,Form3,Nlist,Nlist1,perf) :-
   PROGRAM=..[Voice,Verb,Form3,Nlist,Nlist1,perf], call(PROGRAM).
non_progressive(Voice,Verb,Form3,Nlist,Nlist1) :-
   PROGRAM=..[Voice,Verb,Form3,Nlist,Nlist1], call(PROGRAM).
non_progressive(Verb) :-
   printb(Verb).
non_progressive(Pred,Form3,Nlist,Nlist1) :-
   form3(Pred,Form3,Nlist,Nlist1).

progressive(Time,Number,Verb,Verbforms,Subj,Nlist,Nlist1) :-
   aux(be,Time,Number),
   printterm(Subj,Case,Clause,Nlist,Nlist1,no),
   printprog(Verb,Verbforms).
progressive(Pred,Form3,Nlist,Nlist1) :-
   printb(being),
   form3(Pred,Form3,Nlist,Nlist1).
progressive(Verb) :-
   printb(be),
   printprog(Verb).
progressive(Voice,Pred,Form3,Nlist,Nlist1,perf) :-
   printb(been),
   PROGRAM=..[Voice,Pred,Form3,Nlist,Nlist1,prog], call(PROGRAM).
progressive(Verb,Form3,perf) :-
   printb(been),
   printprog(Verb,Form3).
progressive(Voice,Verb,Form3,Nlist,Nlist1) :-
   printb(be),
   PROGRAM=..[Voice,Verb,Form3,Nlist,Nlist1,prog], call(PROGRAM).

printprog(Verb,Verbforms) :-
   erase_e(Verb,Verb1),
   suffix(Verb1,ing,ProgForm),
   printbm(ProgForm).



present(Number,Verb,P,N,N) :-
   PROGRAM=..[Number,Verb], call(PROGRAM).

present(Voice,Perf,Prog,Pred,Form3,Nlist,Nlist1,inf) :-
   PROGRAM=..[Perf,Prog,Voice,Pred,Form3,Nlist,Nlist1], call(PROGRAM).

past(Number,Verb,regular,N,N) :-
   !,
   erase_e(Verb,Verb1),
   suffix(Verb1,ed,Form2),
   printbm(Form2).
past(Number,Verb,Form2,N,N) :-
   printb(Form2).
past(Voice,Perf,Prog,Pred,Form3,Nlist,Nlist1,inf) :-
   perfect(Prog,Voice,Pred,Form3,Nlist,Nlist1).

aux(Aux,Time,Number) :-
   PROGRAM=..[Aux,Auxlist], call(PROGRAM),
   member([Auxform,Time,Number],Auxlist),
   printb(Auxform).

form3(Term,noun,Nlist,Nlist1) :-
   printterm(Term,Case,Clause,Nlist,Nlist1,no).
form3(Verb,regular,N,N) :-
   !,
   erase_e(Verb,Verb1),
   suffix(Verb1,ed,Form3),
   printbm(Form3).
form3(Verb,Form3,N,N) :-
   printb(Form3).





/***********************************************************************************/


/* Version vom 8.12.2003 */


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

/* Simple predicates that are true or false with respect to the value of
   the variable. */
isPassive(passive).
isActive(active).

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



/******************************************************************************/
/*** Term-Formation ***********************************************************/
/******************************************************************************/
formTerm(verb,Verb,Role,Restr,Verb,Alist,Alist,Q,Qt,Ill).
formTerm(adj,Adj,Role,Restr,Adj,Alist,Alist,Q,Qt,Ill).
formTerm(_Kind, unexpressed, _Role, _Restr, [[],[],unexpressed,[],[],[],[]], _Alist, _Alist3, _Q, _Qt, _Ill).
formTerm(_Kind,Det,Number,Noun,Role,Restr,Term,Alist,Alist3,Q,Qt,Ill) :-
   member(Noun,Nlist),
   !,
   noun(Noun,SelRestr,[Plural,Gender],[[ArgRole,ArgSelRestr,Arg]],Sat),
   add_member([Termop,Noun,[ArgSelRestr,Plural,Gender],Modif],Alist,Alist1),
/* askof(Kind,Noun,Ans),
   of(Noun,Nlist,Relphrase,Alist1,Alist2,Ans), */
/*   write('Is determiner of '),
   printquote(Noun),
   readDet(Det),
   readNumber(Number),*/
   eq(Termop,[Det,Number]),
   check_det(Det,Role,Term,Q,Qt,Ill),
/*   write('vor rel in form_term: Termop '),write(Termop),nl,
   rel(Termop,Noun,[ArgSelRestr,Plural,Gender],Relclause,Alist2,Alist3),
   ask_for_raising(Kind,Relclause,Reply),
   raise_adj(Kind,Modif,Modif1,Relclause,Relclause1,Reply),*/
  /* macht aus "Jo is a man, who talks." "Jo is a talking man." */
   eq(Term,[P,Termop,Noun,[ArgSelRestr,Plural,Gender],Modif1,Relphrase,Relclause1]),
   write('This is the formed Term: '),write(Term),nl.

formTerm(argument,wh,Role,Restr,Term,Nlist,Alist,Alist,Role,Term,
   question) :-
   ask_gender(Role,Restr,Gender),
   eq(Term,[question,[[],sing],wh,[S,P,Gender],[],[],Rel]),
   write('Term: '),write(Term),nl.

formTerm(argument,ProperNoun,Role,Restr,Term,Nlist,Alist,Alist2,Q,Qt,
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

/******************************************************************************/
/*** Lexicon ******************************************************************/
/******************************************************************************/
verb(believe,state,[regular, regular],[[experiencer,human,X1],[goal,proposition,X2]],Satellites).
/* F�r give m��te statt goal,any eine Selektionsrestriktion der Art
   not(human) o.�. realisiert werden. */
verb(give,action,[gave,given],[[agent,animate,X1],[goal,any,X2],[recipient,animate,X3]],Satellites).
verb(have,state,[had,had],[[possessor,human,X1],[goal,any,X2]],Satellites).
verb(kill,action,[regular, regular],[[agent,any,X1],[goal,animate,X2]],Satellites).
verb(learn,action,[regular, regular],[[agent,animate,X1],[goal,learnable,X2]],Satellites).
verb(love,state,[regular, regular],[[experiencer,animate,X1],[goal,any,X2]],Satellites).
verb(please,action,[regular, regular],[[agent,any,X1],[goal,animate,X2]],Satellites).
verb(seem,state,[regular, regular],[[argument,proposition,X2]],Satellites).
verb(show,action,[regular,shown],[[agent,animate,X],[goal,any,X2],[experiencer,animate,X3]],Satellites).
verb(talk,action,[regular, regular],[[agent,animate,X1]],Satellites).
verb(walk,action,[regular, regular],[[agent,animate,X1]],Satellites).
verb(want,state,[regular, regular],[[experiencer,human,X1],[goal,proposition,X2]],Satellites).
verb(write,action,[wrote,written],[[agent,animate,X1],[goal,readable,X2]],Satellites).

verblist([believe,give,have,kill,learn,love,please,seem,show,talk,walk,want,write]).

noun(axe,instrument,[regular,neuter],[[argument,instrument,X]],Sat).
noun(book,readable,[regular,neuter],[[argument,readable,X]],Sat).
noun(cat,animate,[regular,neuter],[[argument,animate,X]],Sat).
noun(computer,instrument,[regular,neuter],[[argument,instrument,X]],Sat).
noun(duckling,animate,[regular,neuter],[[argument,animate,X]],Sat).
noun(farmer,human,[regular,masc],[[argument,human,X]],Sat).
noun(language,learnable,[regular,neuter],[[argument,learnable,X]],Sat).
noun(letter,readable,[regular,neuter],[[argument,readable,X]],Sat).
noun(man,human,[men,masc],[[argument,human,X]],Sat).
noun(woman,human,[women,fem],[[argument,human,X]],Sat).

nounlist([axe,book,cat,computer,duckling,farmer,language,letter,man,woman]).

adj(big,size,[[],big],[[argument,any,X]],Sat).
adj(eager,quality,[[],eager],[[first_argument,animate,X1],[second_argument,infinitive,X2]],Sat).
adj(easy,quality,[[],easy],[[argument,infinitive,X]],Sat).
adj(happy,quality,[[],happy],[[argument,any,X]],Sat).
adj(new,age,[[],new],[[argument,any,X]],Sat).
adj(old,age,[[],old],[[argument,any,X]],Sat).
adj(small,size,[[],small],[[argument,any,X]],Sat).
adj(useful,quality,[[],useful],[[argument,any,X]],Sat).
adj(young,age,[[],young],[[argument,any,X]],Sat).

adjlist([big,eager,easy,new,old,small,useful,young]).





/*********************************************************************************/


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



/**************************************************************************/

/* 1. HILFSPRAEDIKATE */

eq(X,X).
noteq(X,Y) :-
   not(eq(X,Y)).


write_nl(X) :-
   write(X),
   nl.

outl(X) :- write_nl(X).

string_ident(X,Y) :- name(Y,X).

setnil(Var) :-
   eq(Var,[]).
setnil(Var).

setdecl(Illocution) :-
   eq(Illocution,decl).
setdecl(Illocution).

lines(1) :- nl.
lines(2) :-
   nl,nl.
lines(3):-
   nl,nl,nl.


comma:-
   write(', ').

/* =============================================================== */
/* HILFSPRAEDIKATE aus fg */
newargs(Args,NewArgs) :-
   eq(Args,NewArgs),
   !.
newargs(Args,NewArgs).

append_letter(Word, Letter, Word2) :-
    char_code(Letter, Letter2),
    atom_codes(Word, WordList),
    append(WordList, [Letter2], WordList2),
    atom_codes(Word2, WordList2).

/* =============================================================== */
/* HILFSPRAEDIKATE aus expr-rules*/

/* Die beiden folgenden Pr�dikate werden versuchweise auskommentiert.
   In SWI-Prolog erzeugen sie eine Fehlermeldung, da sie statische Pr�dikate
   �berschreiben.
last(X,[X]).

last(X,[Head|Tail]) :-
   last(X,Tail).

is_list([]).
is_list([_|_]). */

:- dynamic expression_result/1.

printb(X) :-
   write(' '),
   assertz(expression_result(X)),
  write(X).

printbm(X) :-
   write(' '),
   assertz(expression_result(X)),
   write(X).

printc(capitalize,mainclause,Word) :-
   !,
   capitalize(Word,W1),
   printbm(W1).

printc(C,Cl,Word) :-
   printbm(Word).

printc(C,Cl,Word) :-
   printb(Word).

printcm(Cap,mainclause,' ',Modif,Noun,plural,Plural) :-
   plural(Cap,mainclause,Modif,Noun,Plural).

printcm(Cap,Clause,String,Modif,Noun,Num,Plural) :-
   name(Word,String),
   printc(Cap,Clause,Word),
   PROGRAM=..[Num,Cap,String,Modif,Noun,Plural], call(PROGRAM).

printquote(Word) :-
   write('"'),
   write(Word),
   write('"').

questionmark :-
   write('?'),
   nl.

writep('?') :- write('?') , !.

writep(X) :- write('.').

printlist(L) :-
   write('{'),
   writelist(L),
   write(' }'),
   nl.

writelist([]). /* nil ersetzt durch [] */

writelist([Head]) :-
   !,
   write(' '),
   write(Head).

writelist([Head|Tail]) :-
   write(' '),
   write(Head),
   write(','),
   writelist(Tail).

writelistc(Cap,Clause,[Head|Tail]) :-
   printc(Cap,Clause,Head),
   writelist(Tail).

check(yes,Positive,Negative,Result) :-
   eq(Result,Positive).

check(no,Positive,Negative,Result) :-
   eq(Result,Negative).

prefix(Prefix,Word,Result) :-
   string_ident(Word1,Word),
   conc_string(Prefix,Word1,Result).

suffix(Word,Suffix,Result) :-
 /*  string_ident(Word1,Word), */
   conc_string(Word,Suffix,Result).


/*append([],L,L).
append([Head,Tail],L2,[Head|Result]) :-
   append(Tail,L2,Result).*/

/* member(Head,[Head|Tail]) :- !.
member(A,[Head|Tail]) :-
   member(A,Tail).*/

del(X,[],[]). /* nil ersetzt durch [] */

del(Head,[Head|Tail],Tail) :- !.

del(A,[Head|Tail],[Head|Newlist]) :-
   del(A,Tail,Newlist).

add_member([],L,L) :- !.  /* nil ersetzt durch [] */

add_member(A,List,List) :-
   member(A,List),
   !.
add_member(A,List,[A|List]).

firstletter(L,Word) :-
   name(Word,[K|Tail]),
   name(L,[K]).

lastletter(L,Word) :-
   string_ident(Word1,Word),
   append(String,[Last],Word1),
   name(L,[Last]).

erase_last(Word,NewWord) :-
   string_ident(Word1,Word),
   append(String,[Last],Word1),
   string_ident(String,NewWord).

erase_e(Verb,Verb1) :-
   lastletter('e',Verb),
   !,
   erase_last(Verb,Verb1).

erase_e(Verb,Verb1) :-
   eq(Verb,Verb1).

conc_string(Word1, Word2, Result) :-
   name(Word1, W1),
   name(Word2, W2),
   append(W1, W2, W3),
   name(Result, W3).

capitalize(Word, Result) :-
    name(Word, [H|Tail]),
    K is H - 32,
    name(Result, [K|Tail]).

small_cap(S,C) :-
   name(S,[Code]),
   C1 is Code - 32,
   name(C,[C1]).

