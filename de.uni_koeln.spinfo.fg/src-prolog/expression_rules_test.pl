% Part of "Functional Grammar Language Generator" (http://fgram.sourceforge.net/) (C) 2006 Christoph Benden
% This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.
% This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
% You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 
 :- initialization ensure_loaded('expression_rules.pl').
 :- initialization ensure_loaded('helpers.pl').
 :- initialization ensure_loaded('lexicon.pl').
 %%%%%%%%%%%%%%%%%%%%%%% Tests %%%%%%%%%%%%%%%%%%%%%%%%
   %TODO ensure initiaized the required files(s)
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

   
