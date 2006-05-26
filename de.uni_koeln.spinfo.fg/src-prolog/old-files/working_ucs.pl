node(x1, 0).
node(x2, 1).
node(x3, 1).
%node(x4, 2).

prop(clause, illocution, decl).
prop(clause, type, mainclause).

prop(x1, type, pred).
prop(x1, lex, 'please').
prop(x1, tense, present).
prop(x1, perfect, true).
prop(x1, progressive, false).
prop(x1, mode, ind).
prop(x1, voice, active).
prop(x1, subnodes, [x2, x3]). % = arguments, satellites

prop(x2, type, term).
prop(x2, lex, 'man').
prop(x2, pragmatic, null). % This is the place to define Theme
prop(x2, role, agent).
prop(x2, relation, subject).
prop(x2, proper, true). % Default: false
prop(x2, det, def).     % null-value might be necessary in case of proper nouns, will be converted to []
prop(x2, num, sing).
prop(x2, modifs, ['little']).

prop(x3, type, term).
prop(x3, lex, 'woman').
prop(x3, pragmatic, null).
prop(x3, role, goal).
prop(x3, relation, object).
prop(x3, proper, false). % Default: false
prop(x3, det, def).
prop(x3, num, sing).
prop(x3, modifs, ['little']).