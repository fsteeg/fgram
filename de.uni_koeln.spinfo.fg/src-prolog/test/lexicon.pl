% Author:
% Date: 06.03.03

/* LEXICON */
verb(believe,state,[regular, regular],[[experiencer,human,X1],[goal,proposition,X2]],Satellites).
verb(give,action,[gave,given],[[agent,animate,X1],[goal,any,X2],[recipient,animate,
     X3]],Satellites).
verb(have,state,[had,had],[[possessor,human,X1],[goal,any,X2]],Satellites).
verb(kill,action,[regular, regular],[[agent,any,X1],[goal,animate,X2]],
     Satellites).
verb(learn,action,[regular, regular],[[agent,animate,X1],[goal,learnable,X2]],
     Satellites).
verb(love,state,[regular, regular],[[experiencer,animate,X1],[goal,any,X2]],
     Satellites).
verb(please,action,[regular, regular],[[agent,any,X1],[goal,animate,X2]],
     Satellites).
verb(seem,state,[regular, regular],[[argument,proposition,X2]],Satellites).
verb(show,action,[regular,shown],[[agent,animate,X],[goal,any,X2],[experiencer,animate,X3]],
     Satellites).
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
adj(eager,quality,[[],eager],[[first_argument,animate,X1],
                                    [second_argument,infinitive,X2]],Sat).
adj(easy,quality,[[],easy],[[argument,infinitive,X]],Sat).
adj(happy,quality,[[],happy],[[argument,any,X]],Sat).
adj(new,age,[[],new],[[argument,any,X]],Sat).
adj(old,age,[[],old],[[argument,any,X]],Sat).
adj(small,size,[[],small],[[argument,any,X]],Sat).
adj(useful,quality,[[],useful],[[argument,any,X]],Sat).
adj(young,age,[[],young],[[argument,any,X]],Sat).

adjlist([big,eager,easy,new,old,small,useful,young]).

