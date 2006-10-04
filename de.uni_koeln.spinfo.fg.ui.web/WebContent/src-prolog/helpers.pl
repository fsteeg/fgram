% Part of "Functional Grammar Language Generator" (http://fgram.sourceforge.net/) (C) 1989-2006 Paul O. Samuelsdorff, Christoph Benden
% This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.
% This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
% You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA


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
