% Part of "Functional Grammar Language Generator" (http://fgram.sourceforge.net/) (C) 1989-2006 Paul O. Samuelsdorff, Christoph Benden
% This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.
% This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
% You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

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

  

/* Simple predicates that are true or false with respect to the value of
   the variable. */
isPassive(passive).
isActive(active).


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


  