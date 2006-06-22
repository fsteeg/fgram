:- initialization ensure_loaded('expression_rules.pl').
:- initialization ensure_loaded('helpers.pl').
:- initialization ensure_loaded('lexicon.pl').

run_all :-
    write('Test: test'), nl, test,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 0'), nl, test0,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 1'), nl, test1,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 2'), nl, test2,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 3'), nl, test3,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 4'), nl, test4,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 5'), nl, test5,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 6'), nl, test6,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 7'), nl, test7,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 8'), nl, test8,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 9'), nl, test9,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 10'), nl, test10,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 11'), nl, test11,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 12'), nl, test12,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 13'), nl, test13,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 14'), nl, test14,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 15'), nl, test15,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 16'), nl, test16,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 17'), nl, test17,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 18a'), nl, test18a,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 18b'), nl, test18b,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 19'), nl, test19,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 20'), nl, test20,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 21'), nl, test21,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 22'), nl, test22,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 23'), nl, test23,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 24'), nl, test24,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 25'), nl, test25,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 26'), nl, test26,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 27'), nl, test27,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 28'), nl, test28,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 29'), nl, test29,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 31a'), nl, test31a,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 31b'), nl, test31b,
    nl, write('------------------------------------------------------------'), nl,
    write('Test: 32'), nl, test32.


test:-
expression_rules(decl, mainclause, [state,passive,[ind,past,non_perfect,non_progressive,_],
[believe,[regular,regular]],[[],[action,active,[ind,past,perfect,progressive,_],
[walk,[regular,regular]],[[],[_,[[],sing],john,[human,sing,masc],[],[],[]],[],[],[]]],[],
[[experiencer,human,[_,[def,sing],woman,[human,women,fem],[],[],[]]]],[]]],
[wh],_,Punctuation), writep(Punctuation),nl.


test0:-
expression_rules(decl, mainclause,
[human,passive,[ind,past,perfect,non_progressive,_],
[[_,[indef,_],man,[human,men,masc],[],[],[]],[noun,noun]],
[[],[_,[[],sing],john,[human,sing,masc],[],[],[]],[],[],[]]],
[wh],_,Punctuation), writep(Punctuation),nl.


test1:-
expression_rules(decl,mainclause,[action,active,[ind,past,perfect,non_progressive,_],
[walk,[regular,regular]],[[],[_,[def,sing],woman,[human,women,fem],[],[],[]],[],[],[]]],
[wh],_,Punctuation),writep(Punctuation),nl.

test2 :- expression_rules(decl,mainclause,[action,active,[ind,present,perfect,progressive,
_],[walk,[regular,regular]],[[],[_,[total,sing],man,[human,men,masc],_,[],[]
],[],[],[]]],[wh],_,Punctuation), writep(Punctuation).


test3:-
expression_rules(decl,mainclause,[action,active,[ind,past,non_perfect,non_progressive,_],
[kill,[regular,regular]],[[],[_,[def,sing],farmer,[human,regular,masc],[],[],[]],
[_,[def,sing],duckling,[animate,regular,neuter],[],[],[]],[],[]]],[wh],_,Punctuation),
writep(Punctuation),nl.

test4:-
expression_rules(decl, mainclause, [action,passive,[ind,past,non_perfect,
non_progressive,_],[kill,[regular,regular]],[[],[_,[def,sing],duckling,
[animate,regular,neuter],[],[],[]],[],[[agent,any,[_,[def,sing],
farmer,[human,regular,masc],[],[],[]]]],[]]],
[wh],_,Punctuation), writep(Punctuation),nl.


test5:-
expression_rules(question,mainclause,[action,active,[ind,past,non_perfect,non_progressive,
_],[kill,[regular,regular]],[[],[question,[[],sing],wh,
[_,_,human],[],[],[]],[_,[def,sing],duckling,[animate,regular,neuter],
[],[],[]],[],[]]],
[wh],_,Punctuation),writep(Punctuation),nl.

test6:-
expression_rules(decl, mainclause, [action,active,[ind,past,non_perfect,
non_progressive,_],[kill,[regular,regular]],
[[],[_,[indef,sing],farmer,[human,regular,masc],[],[],[]],
[_,[total,sing],duckling,[animate,regular,neuter],[],[],[]],[],[]]],
[wh],_,Punctuation), writep(Punctuation),nl.

test7:-
expression_rules(decl, mainclause, [action,active,
[ind,past,non_perfect,non_progressive,_],
[kill,[regular,regular]],[[],[_,[[],sing],john,[human,sing,masc],[],[],[]],
[_,[nprox,sing],duckling,[animate,regular,neuter],[small,'evil grinning'],[],[]],[],
[[instrument,instrument,[_,[indef,sing],axe,[instrument,regular,neuter],[],
[],[]]]]]],
[wh],_,Punctuation), writep(Punctuation),nl.

test8:-
expression_rules(decl, mainclause, [state,active,[ind,past,non_perfect,
non_progressive,_],[believe,[regular,regular]],
[[],[_,[def,sing],woman,[human,women,fem],[],[],[]],
[action,active,[ind,past,perfect,non_progressive,_],[kill,[regular,regular]],
[[],[_,[[],sing],john,[human,sing,masc],[],[],[]],
[_,[def,sing],farmer,[human,regular,masc],[],[],[]],[],[]]],[],[]]],
[wh],_,Punctuation), writep(Punctuation),nl.


test9:-
expression_rules(decl, mainclause, [state,active,[ind,past,non_perfect,non_progressive,_],
[believe,[regular,regular]],[[],[_,[def,sing],woman,[human,women,fem],[],[],[]],
[_,[[],sing],john,[human,sing,masc],[],[],[]],
[goal,inf,[action,active,[ind,past,non_perfect,non_progressive,_],
[kill,[regular,regular]],[[_,[def,sing],farmer,[human,regular,masc],[],[],[]],[],[]]]],[]]],
[wh],Nlist,Punctuation), writep(Punctuation),nl.

test10:-
expression_rules(decl, mainclause, [state,active,
[ind,past,non_perfect,non_progressive,_],
[believe,[regular,regular]],[[],[_,[def,sing],woman,[human,women,fem],[],[],[]],
[_,[def,sing],farmer,[human,regular,masc],[],[],[]],
[goal,inf,[action,passive,[ind,past,non_perfect,non_progressive,_],
[kill,[regular,regular]],[[],[[agent,any,[_,[[],sing],john,[human,sing,masc],[],[],[]]]],[]]]],
[]]], [wh],Nlist,Punctuation), writep(Punctuation),nl.

test11:-
expression_rules(decl, mainclause, [state,passive,
[ind,past,non_perfect,non_progressive,_],[believe,[regular,regular]],
[[],[_,[def,sing],farmer,[human,regular,masc],[],[],[]],[],
[[experiencer,human,[_,[def,sing],woman,[human,women,fem],[],[],[]]],
[goal,inf,[action,passive,[ind,past,non_perfect,non_progressive,_],
[kill,[regular,regular]],[[],[[agent,any,[_,[[],sing],john,[human,sing,masc],[],[],[]]]],
[]]]]],[]]], [wh],Nlist,Punctuation), writep(Punctuation),nl.

test12:-
expression_rules(decl, mainclause,
[action,active, [ind,past,non_perfect,non_progressive,_],[give,[gave,given]],
    [   [],
        [_,[def,sing],farmer,[human,regular,masc],[],[],[]],
        [_,[def,sing],axe,[instrument,regular,neuter],[],[],[]],
        [[recipient,animate,[_,[[],sing],john,[human,sing,masc],[],[],[]]]],
        []
    ]
] /* End of PRED */,
[wh], Nlist,Punctuation), writep(Punctuation),nl.

test12a:-
expression_rules(decl, mainclause,
[action,active, [ind,past,non_perfect,non_progressive,_],[give,[gave,given]],
    [   [],
        [_,[def,sing],farmer,[human,regular,masc],[],[],[]],
        [_,[def,sing],axe,[instrument,regular,neuter],[],[],[]],
        [ [recipient, [def, plural], woman, [human, women, fem], _G598, _G601, _G604] ],
        []
    ]
] /* End of PRED */,
[wh], Nlist,Punctuation), writep(Punctuation),nl.


test13:-
expression_rules(decl, mainclause,
[action,active,[ind,past,non_perfect,non_progressive,_],
[give,[gave,given]],[[],[_,[def,sing],farmer,[human,regular,masc],[],[],[]],
[_,[[],sing],john,[human,sing,masc],[],[],[]],
[[goal,any,[_,[def,sing],axe,[instrument,regular,neuter],[],[],[]]]],[]]],
[wh],Nlist,Punctuation), writep(Punctuation),nl.

test14:-
expression_rules(decl, mainclause,
[action,active,[ind,past,non_perfect,non_progressive,_],
[kill,[regular,regular]],[[],[_,[def,sing],axe,[instrument,regular,neuter],[],[],[]],
[_,[def,sing],duckling,[animate,regular,neuter],[],[],
[state,active,[ind,past,non_perfect,non_progressive,_],
[love,[regular,regular]],[[rel,[def,sing],duckling,[animate,regular,neuter],
_,_,[]],[_,[[],sing],john,[human,sing,masc],[],[],[]],
[],[],[]]]],[],[]]],
[wh],Nlist,Punctuation), writep(Punctuation),nl.


test15:-
expression_rules(decl, mainclause,
[action,active,[ind,past,non_perfect,non_progressive,_],[kill,[regular,regular]],
[[],[_,[def,sing],man,[human,men,masc],[],_,[]],
[_,[def,sing],cat,[animate,regular,neuter],[],_,
[state,active,[ind,past,non_perfect,non_progressive,_],[love,[regular,regular]],
[[rel,[def,sing],cat,[animate,regular,neuter],_,_,[]],
[_,[[],sing],di,[human,sing,fem],[],[],[]],[],[],[]]]],[],[]]],
[wh],Nlist,Punctuation), writep(Punctuation),nl.

test16:-
expression_rules(decl, mainclause,
[quality,passive,[ind,present,non_perfect,non_progressive,_],[eager,[[],eager]],
[[],[_,[[],sing],jo,[human,sing,masc],[],[],[]],[],
[[second_argument,inf,[action,active,[ind,present,non_perfect,non_progressive,_],
[please,[regular,regular]],[[[],[],unexpressed,[],[],[],[]],[],[]]]]],[]]],
[wh],Nlist,Punctuation), writep(Punctuation),nl.

test17:- expression_rules(decl, mainclause,
[human,passive,[ind,present,non_perfect,non_progressive,_],
[[_,[def,sing],man,[human,men,masc],[],_,
[action,passive,[ind,past,non_perfect,non_progressive,_],
[give,[gave,given]],[[],[rel,[def,sing],man,[human,men,masc],_,_,[]],[],
[[goal,any,[_2192,[indef,sing],book,[readable,regular,neuter],[],_2202,[]]]],
[[agent,animate,[_15032,[[],sing],di,[human,sing,fem],[],[],[]]],
[time_point,time_point,[_23570,[[],sing],friday,[_41156,sing,neuter],[],[],[]]]]]]],
[noun,noun]],[[],[_31348,[[],sing],jo,[human,sing,masc],[],[],[]],[],[],[]]],
[wh],Nlist,Punctuation), writep(Punctuation),nl.

/*
test18:-
  expression_rules(
    decl,
    mainclause,
    [ human, passive, [ind,present,non_perfect,non_progressive,_43498],     % [Class, Voice, [Mod, Time, Perf, Prog, Num]
      [                                                                     % Verb_1
        [_19836,[def,sing],man,[human,men,masc],[],_19852,
          [action,passive,[ind,past,non_perfect,non_progressive,_29212],                         % [Class, Voice, [Mod, Time, Perf, Prog, Num]
            [give,[gave,given]],                                                                 % [Verb, Vbforms]
            [ [rel,[def,sing],man,[human,men,masc],_40546,_40548,[]],                            % Theme
              [_24000,[indef,sing],book,[readable,regular,neuter],[],_24010,[]],                 % Subj
              [],                                                                                % Obj
              [ [recipient,animate,[rel,[def,sing],man,[human,men,masc],_40546,_40548,[]]] ],    % Restargs
              [ [agent,animate,[_34830,[[],sing],di,[human,sing,fem],[],[],[]]],                 % Satellites
                [time_point,time_point,[_23228,[[],sing],friday,[_41012,sing,neuter],[],[],[]]]  % Satellites
              ]
            ]
          ]
        ],
        [noun,noun]                                                         % Vbforms_1
      ],
      [ [],                                                                 % Theme
        [_45772,[[],sing],jo,[human,sing,masc],[],[],[]],                   % Subj
        [],                                                                 % Obj
        [],                                                                 % Restargs
        []                                                                  % Satellites
      ]
    ],
    [wh],                                                   % Nlist
    Nlist,                                                  % Nlistout
    Punctuation),                                           % '.'
  writep(Punctuation),
  nl.
*/

test18a:-
expression_rules(decl, mainclause,
[human,passive,[ind,present,non_perfect,non_progressive,_],[[_,[def,sing],man,
[human,men,masc],[],_,[action,passive,[ind,past,non_perfect,non_progressive,_],
[give,[gave,given]],[[recipient,[rel,[def,sing],man,[human,men,masc],_,_,[]]],
[_,[indef,sing],book,[readable,regular,neuter],[],_,[]],[],[],[[agent,animate,
[_,[[],sing],di,[human,sing,fem],[],[],[]]],[time_point,time_point,[_,[[],sing],
friday,[_,sing,neuter],[],[],[]]]]]]],[noun,noun]],[[],[_,[[],sing],joe,
[human,sing,masc],[],[],[]],[],[],[]]],
[wh],_,Punctuation), writep(Punctuation),nl.

test18b:-
expression_rules(decl, mainclause,
[human,passive,[ind,present,non_perfect,non_progressive,_],[[_,[def,sing],man,
[human,men,masc],[],_,[action,passive,[ind,past,non_perfect,non_progressive,_],
[give,[gave,given]],[[],[rel,[def,sing],man,[human,men,masc],_,_,[]],[],
[[goal,any,[_,[indef,sing],book,[readable,regular,neuter],[],_,[]]]],
[[agent,animate,[_,[[],sing],di,[human,sing,fem],[],[],[]]],
[time_point,time_point,[_,[[],sing],friday,[_,sing,neuter],[],[],[]]]]]]],
[noun,noun]],[[],[_,[[],sing],jo,[human,sing,masc],[],[],[]],[],[],[]]],
[wh],Nlist,Punctuation), writep(Punctuation),nl.


test19:-
expression_rules(decl, mainclause,
[human,passive,[ind,present,non_perfect,non_progressive,_],[[_,[def,sing],man,
[human,men,masc],[],_,[action,passive,[ind,past,non_perfect,non_progressive,_],
[give,[gave,given]],[[recipient,[rel,[def,sing],man,[human,men,masc],_,_,[]]],
[_,[indef,sing],book,[readable,regular,neuter],[],_,[]],[],[],[[agent,animate,
[_,[[],sing],di,[human,sing,fem],[],[],[]]],[time_point,time_point,[_,[[],sing],
friday,[_,sing,neuter],[],[],[]]]]]]],[noun,noun]],[[],[_,[[],sing],jo,
[human,sing,masc],[],[],[]],[],[],[]]],
[wh],Nlist,Punctuation), writep(Punctuation),nl.

test20:-
expression_rules(decl, mainclause,
[state,active,[ind,past,non_perfect,non_progressive,_],[want,[regular,regular]],
[[],[_,[def,sing],man,[human,men,masc],[],_,[]],[],
[[goal,inf,[action,active,[ind,present,non_perfect,non_progressive,_],
[walk,[regular,regular]],[[],[],[]]]]],[]]],
[wh],Nlist,Punctuation), writep(Punctuation),nl.

test21:-
expression_rules(decl, mainclause,
[quality,passive,[ind,present,non_perfect,non_progressive,_],
[easy,[[],easy]],[[],_,[],[[argument,inf,[action,active,[ind,present,non_perfect,non_progressive,_14174],
[please,[regular,regular]],[[_,[[],sing],jo,[human,sing,masc],[],[],[]],[],[]]]]],[]]],
[wh],Nlist,Punctuation), writep(Punctuation),nl.

test22:-
expression_rules(decl, mainclause,
[state,active,[ind,present,non_perfect,non_progressive,_],
[seem,[regular,regular]],[[],[_,[[],sing],jo,[human,sing,masc],[],[],[]],[],
[[goal,inf,[human,passive,[ind,present,non_perfect,non_progressive,_],
[[_,[indef,sing],man,[human,men,masc],[],_,[]],[noun,noun]],[[],[],[]]]]],[]]],
[wh],Nlist,Punctuation), writep(Punctuation),nl.

test23:-
expression_rules(decl, mainclause,
[quality,passive,[ind,present,non_perfect,non_progressive,_],
[easy,[[],easy]],[[],_,[],
[[argument,infinitive,[human,passive,[ind,present,non_perfect,non_progressive,_],
[[_,[indef,sing],man,[human,men,masc],[],_,[]],[noun,noun]],[[],[],[]]]]],[]]],
[wh],Nlist,Punctuation), writep(Punctuation),nl.

test24:-
expression_rules(decl, mainclause,
[human,passive,[ind,present,non_perfect,non_progressive,_],
[[_,[indef,sing],man,[human,men,masc],[],_,[]],[noun,noun]],[[],[_,[[],sing],
jo,[human,sing,masc],[],[],[]],[],[],[]]],
[wh],Nlist,Punctuation), writep(Punctuation),nl.

test25:-
expression_rules(decl, mainclause,
[size,passive,[ind,present,non_perfect,non_progressive,_],
[big,[[],big]],[[],[_,[[],sing],
jo,[human,sing,masc],[],[],[]],[],[],[]]],
[wh],Nlist,Punctuation), writep(Punctuation),nl.

test26:-
expression_rules(decl, mainclause,
[quality, passive, [ind, present, non_perfect, non_progressive, _],
[easy, [[], easy]], [[], [_, [def, sing], man, [human, men, masc],
[], _, []], [], [[argument, infinitive,
[action, active, [ind, present, non_perfect, non_progressive, _],
[please, [regular, regular]], [[],[],
[]]]]], []]], [wh],Nlist,Punctuation), writep(Punctuation),nl.

test27 :-  % 'The woman walked.'
expression_rules(     decl,
                      mainclause,
                      [action, active, [ind, past, non_perfect, non_progressive, _],
                               [walk, [regular, regular]], [[], [_, [def, sing], woman,
                               [human, women, fem], [], _, []], [], [], []]],
                      [wh],
                      Nlist,
                      Punctuation),


                      writep(Punctuation),nl.

test28 :- % Sue was killed by the man who loved her.
expression_rules(decl, mainclause,
[action, passive, [ind, past, non_perfect, non_progressive, _],
[kill, [regular, regular]], [[], [_, [[], sing], sue, [human, sing, fem],
[], [], []], [], [], [[agent, any, [_, [def, sing], man, [human, men, masc],
[], _, [state, active, [ind, past, non_perfect, non_progressive, _],
[love, [regular, regular]], [[], [rel, [def, sing], man, [human, men, masc], _,
_, []], [_, [[], sing], sue, [human, sing, fem], [], [], []], [], []]]]]]]],
[wh],_,Punctuation), writep(Punctuation),nl.

test29 :- % The man walks.  <= [Pres[Ei:[Progr[walk[V](d1Xi:man[N])Ag)]]]
expression_rules(decl, mainclause,
[action, active, [ind, present, non_perfect, non_progressive, _G712],
[walk, [regular, regular]], [[], [_G386, [def, sing], man, [human, men, masc],
[], _G401, []], [], [], []]],
[wh],Nlist,Punctuation), writep(Punctuation),nl.

% The man is walking. <= [Decl Ei:[Ind Xi:[Pres ei:[Progr walk[V](d1xi:man[N])Ag)]]]]

test31a:-
expression_rules(decl, mainclause, [state,passive,[ind,past,non_perfect,non_progressive,_],
[believe,[regular,regular]],[[],[action,active,[ind,past,perfect,progressive,_],
[walk,[regular,regular]],[[],[_,[[],sing],john,[human,sing,masc],[],[],[]],[],[],[]]],[],
[[experiencer,human,[_,[def,sing],woman,[human,women,fem],[],[],[]]]],[]]],
[wh],_,Punctuation), writep(Punctuation),nl.

test31b:-
expression_rules(decl, mainclause, [state,passive,[ind,past,non_perfect,non_progressive,_],
[believe,[regular,regular]],[[],[action,active,[ind,past,perfect,progressive,_],
[walk,[regular,regular]],[[],[_,[[],sing],john,[human,sing,masc],[],[],[]],[],[],[]]],[],
[[experiencer,human,[_,[def,sing],woman,[human,women,fem],[],[],[]]]],[[instrument,instrument,[_,[indef,sing],axe,[instrument,regular,neuter],[],
[],[]]]]]],
[wh],_,Punctuation), writep(Punctuation),nl.

test32 :-
expression_rules(decl, mainclause,
[state, active, [ind, present, non_perfect, non_progressive, _G1374], [seem, [regular, regular]],
[[], [_G768, [[], sing], john, [human, sing, masc], [], [], []], [], [[goal, inf,
[quality, passive, [ind, present, non_perfect, non_progressive, _G1131], [easy, [[], easy]],
[[], [[argument, infinitive, [action, active, [ind, present, non_perfect, non_progressive, _G972], [please, [regular, regular]], [[], [], []]]]], []]]]], []]],
[wh],Nlist,Punctuation), writep(Punctuation),nl.

test33:-
expression_rules(decl, mainclause,
[state, active, [ind, present, non_perfect, non_progressive, _G1422], [seem, [regular, regular]], [[], [_G577, [[], sing], john, [human, sing, masc], [], [], []], [], [[goal, inf, [quality, passive, [ind, present, non_perfect, non_progressive, _G1179], [eager, [[], eager]], [[], [[second_argument, inf, [action, active, [ind, present, non_perfect, non_progressive, _G1053], [please, [regular, regular]], [[[], [], unexpressed, [], [], [], []], [], []]]]], []]]]], []]],
[wh],Nlist,Punctuation), writep(Punctuation),nl.

        /* It seems that an old cat walked. */
test34:-
expression_rules(
    decl,
    mainclause,
    [
        state,
        active,
        [ind, present, non_perfect, non_progressive, _G1055],
        [seem, [regular, regular]],
        [
            [],
            [],
            [],
            [
                [
                    action,
                    active,
                    [ind, past, non_perfect, non_progressive, _G935],
                    [walk, [regular, regular]],
                    [
                        [],
                        [_G606, [indef, sing], cat, [animate, regular, neuter], [old], _G621, []],
                        [],
                        [],
                        []
                    ]
                ]
            ],
            []
        ]
    ],
    [wh],
    Nlist,
    Punctuation),
writep(Punctuation),nl.


