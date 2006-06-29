% Part of "Functional Grammar Language Generator" (http://fgram.sourceforge.net/) (C) 2006 Christoph Benden
% This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.
% This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
% You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA


:- initialization ensure_loaded('generated_ucs.pl').
:- initialization ensure_loaded('lexicon.pl').
:- initialization ensure_loaded('helpers.pl').
:- initialization ensure_loaded('expression_rules.pl').

expression(Res) :-
    consult('D:/cbendenWORKSPACE/de.uni_koeln.spinfo.fg/src-prolog/test_ucs.pl'),
    %consult('generated_ucs.pl'), 
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
    readProp(Node, modifs, Modifs), write('Modifs: '), write(Modifs), nl,
    /* Should be changed by time because only expression_rules should
       be used from the old program. */
    formTerm(noun, Det, Num, Lex, Role, Modifs, Term, Alist, Alist3, Q, Qt, Ill).

% This predicate forms Predications. The list in the secaond argument
% represents the actual predication.
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
    write('Initializing: Subnode theme.'), nl,
    % Then: Form the respective structure and store it in Theme.
    formStructureFromNode(ActNode, Theme).

initializeSubnode(ActNode, [_Theme, Subject, _Object, _RestArgs, _Satellites]) :-
    % Is ActNode the (non-Theme) subject of the sentence?
    readProp(ActNode, relation, subject),
    write('Initializing: Subnode subject.'), nl,
    % Then: Form the respective structure and store it in Subject.
    formStructureFromNode(ActNode, Subject).

initializeSubnode(ActNode, [_Theme, _Subject, Object, _RestArgs, _Satellites]) :-
    % Is ActNode the (non-Theme) Object of the sentence?
    readProp(ActNode, relation, object),
    write('Initializing: Subnode object.'), nl,
    % Then: Form the respective structure and store it in Object.
    formStructureFromNode(ActNode, Object).

% Restargs
% This is the general form of a Restargs entry:
% [[recipient, _G777, [_G741, [def, sing], woman, [human, women, fem], _G762, _G765, _G768]]]
% It differs especially with respect to cases where a proper noun is
% used:
%   [[recipient,animate,[_,[[],sing],john,[human,sing,masc],[],[],[]]]]
initializeSubnode(ActNode, [_Theme, _Subject, _Object, RestArg, _Satellites]) :-
    % Is ActNode the (non-Theme) Object of the sentence?
    readProp(ActNode, relation, restarg),
    write('Initializing: Subnode restarg.'), nl,
    readProp(ActNode, role, Role), write('Role for restarg: '), write(role), nl,
    % Then: Form the respective structure and store it in RestArgs.
    formStructureFromNode(ActNode, RestArg1), nl, write('huhu: '), write(RestArg1), nl,
    formRestargsExpression(Role, RestArg1, RestArg),
    nl, write('new restarg: '), write(RestArg) .

formRestargsExpression(Role, [_, E2, E3, E4, E5, E6, E7], [[Role, _, [_, E2, E3, E4, E5, E6, E7]]]).


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











