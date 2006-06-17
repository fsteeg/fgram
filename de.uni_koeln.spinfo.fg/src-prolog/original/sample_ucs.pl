
node(start0, 0, love, props_start0).
node(start1, 1, peter, props_start1).
node(start2, 1, mary, props_start2).


props(props_start0, pred, [start1, start2]).
props(props_start1, arg, [d, 1, agent]).
props(props_start2, arg, [d, 1, goal]).

getProps(Key,Value):-
	props(Key,_,Value).

%getRoleForFirstArg(FirstArgKey, Role)