% Part of "Functional Grammar Language Generator" (http://fgram.sourceforge.net/) (C) 1989-2006 Paul O. Samuelsdorff, Christoph Benden
% This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.
% This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
% You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

% LEXICON

verb(believe,state,[regular, regular],[[experiencer,human,X1],[goal,proposition,X2]],Satellites).
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

adj(big,size,[[],big],[[argument,any,X]],Sat).
adj(eager,quality,[[],eager],[[first_argument,animate,X1],[second_argument,infinitive,X2]],Sat).
adj(easy,quality,[[],easy],[[argument,infinitive,X]],Sat).
adj(happy,quality,[[],happy],[[argument,any,X]],Sat).
adj(new,age,[[],new],[[argument,any,X]],Sat).
adj(old,age,[[],old],[[argument,any,X]],Sat).
adj(small,size,[[],small],[[argument,any,X]],Sat).
adj(useful,quality,[[],useful],[[argument,any,X]],Sat).
adj(young,age,[[],young],[[argument,any,X]],Sat).

% For 'give' instead of 'goal,any' a selection restriction like 'not(human)' should be realized

nounlist([axe,book,cat,computer,duckling,farmer,language,letter,man,woman]).
verblist([believe,give,have,kill,learn,love,please,seem,show,talk,walk,want,write]).
adjlist([big,eager,easy,new,old,small,useful,young]).

% GRAMMATICON

be([
	[was,past,sing],
	[were,past,plural],
	[is,present,sing],
	[are,present,plural]]).

have([
	[had,past,N],
	[has,present,sing],
	[have,present,plural]]).

do([
	[did,past,N],
	[does,present,sing],
	[do,present,plural]]).

determiner([
	["the",def,N,G],
	["a",indef,sing,G],
	["",indef,plural,G],
	["every",total,sing,G],
	["all",total,plural,G],
	["this",prox,sing,G],
	["these",prox,plural,G],
   	["that",nprox,sing,G],
   	["those",nprox,plural,G],
   	["no",neg,N,G],
   	["which",qdef,n,G],
   	["what kind of",qindef,N,G],
   	["how much",qquantity,sing,G],
   	["how many",qquantity,plural,G]]).

pronouns([
	[he,pers,masc,sing,subj],
	[him,pers,masc,sing,ob],
	[she,pers,fem,sing,subj],
   	[her,pers,fem,sing,ob],
   	[it,pers,neuter,sing,C],
   	[they,pers,G,plural,subj],
   	[them,pers,G,plural,ob],
   	[what,question,neuter,N,C],
   	[that,rel,neuter,N,subj],
   	[which,rel,neuter,N,ob],
   	[who,K,G,N,subj],
   	[whom,K,G,N,ob]]).
   	
   	
% GRAMMATICON

be([
	[was,past,sing],
	[were,past,plural],
	[is,present,sing],
	[are,present,plural]]).

have([
	[had,past,N],
	[has,present,sing],
	[have,present,plural]]).

do([
	[did,past,N],
	[does,present,sing],
	[do,present,plural]]).

determiner([
	["the",def,N,G],
	["a",indef,sing,G],
	["every",total,sing,G],
	[...]

pronouns([
	[he,pers,masc,sing,subj],
	[him,pers,masc,sing,ob],
	[she,pers,fem,sing,subj],
   	[...]
   	
   	
   	
   	
   	
   	
   	
   	
% LEXICON

verb(believe,state,[regular, regular],[[experiencer,human,X1],[goal,proposition,X2]],Satellites).
verb(give,action,[gave,given],[[agent,animate,X1],[goal,any,X2],[recipient,animate,X3]],Satellites).
[...]

noun(axe,instrument,[regular,neuter],[[argument,instrument,X]],Sat).
noun(book,readable,[regular,neuter],[[argument,readable,X]],Sat).
[...]

adj(big,size,[[],big],[[argument,any,X]],Sat).
adj(eager,quality,[[],eager],[[first_argument,animate,X1],[second_argument,infinitive,X2]],Sat).
[...]
