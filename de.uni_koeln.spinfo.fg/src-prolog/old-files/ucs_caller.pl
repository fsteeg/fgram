% always reload generated ucs, it may have been updated:
:- initialization consult('generated_ucs.pl').
%
:- initialization ensure_loaded('lexicon.pl').
:- initialization ensure_loaded('ex-rules.pl').

% following only temporarily, cause results are written, should be removed as 
% soon as results are returned

:- initialization ensure_loaded('fg.pl').
:- initialization ensure_loaded('fg2.pl').
:- initialization ensure_loaded('ask-user.pl').

expression_test("Hello,", UL, ML):-
	append("Hello,", UL, ML).

nonDeterministicGoal(InterestingVarsTerm,G,ListTM) :-
  findall(InterestingVarsTerm,G,L), buildTermModel(L,ListTM).

expression(Res):-
	% always remove the old result:
	retractall(expression_result(_)),
	node(x1,depth0,Verb,PropsKey),
	getProps(PropsKey,Arglist),
	verb(Verb, Class, FormsLex, _, _),
	Class = Class,
	Voice = active,
	Mod = ind,
	Time = present,
	Perf = non_perfect,
	Prog = non_progressive,
	Num = sing,
   	Predicate = Verb,
   	Forms = FormsLex,
   	Subject = [_,[[],sing],peter,[human,sing,masc],[],[],[]],
   	Object = [_,[[],sing],mary,[human,sing,fem],[],[],[]],
   	Restargs = [],
   	Satellites = [],
   	Predication = [Class,Voice,[Mod,Time,Perf,Prog,Num],[Predicate,Forms],[[],
   		Subject,Object,Restargs,Satellites]],
   	Illocution = decl,
	expression_rules(Illocution,mainclause,Predication,[wh],_Nlist,Punctuation),
   	writep(Punctuation),nl,
   	append("ucs ", "okay", Res).

/*
node(x1, depth0, love, props_x1).
node(x2, depth1, peter, props_x2).
node(x3, depth1, mary, props_x3).

propsV(ID,      type, arguments, tense, aspect[Pefectivity, Progressivity], modus, predicationType([N] || [V] || [A]))
props(props_x1, pred, [x1, x2]).
props(props_x2, arg, [d, 1, agent]).
props(props_x3, arg, [d, 1, goal]).
*/

getProps(Key,Value):-
	props(Key,_,Value).
