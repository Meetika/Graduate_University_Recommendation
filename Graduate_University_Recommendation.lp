_university(asu).
_university(neu).
_university(tamu).
_university(usc).
_university(utd).
_university(ncsu).
_university(uic).
_university(iit).
_university(nyu).
_university(uncc).
_university(sjsu).
_university(cmu).
_university(uf).
_university(ucsd).
_university(rit).
_university(uiuc).
_university(ucla).
_university(umass).
_university(njit).
_university(upenn).
_university(mit).
_university(nw).
_university(bu).
_university(pace).
_university(uta).
_university(suny).
_university(gatech).
_university(vt).
_university(rutgers).
_university(columbia).
_university(ucb).
_university(ucd).
_university(nyupoly).
_university(duke).
_university(wpi).


_goodGre(A,R):-A-R>=6, A < 335.
_goodGre(A,R) :- A >=335.
_okayGre(A,R):-A-R<6,A-R>=0.
_okayGre(A,R):-R-A=<2,R-A>0.
_badGre(A,R):-not _goodGre(A,R),not _okayGre(A,R).

_goodToefl(A,R):-A-R>=5, A<115.
_goodToefl(A,R):- A >= 115.
_okayToefl(A,R):-A-R<5,A-R>=0.
_okayToefl(A,R):-R-A=<2,R-A>0.
_badToefl(A,R):- not _goodToefl(A,R),not _okayToefl(A,R).

_goodGpa(A,R):-A-R>=0.5, A<9.
_goodGpa(A,R) :- A >= 9.
_okayGpa(A,R):- A-R<0.5,A-R>=0.
_badGpa(A,R):-not _goodGpa(A,R), not _okayGpa(A,R).

_goodWorkex(A,R):-A-R>=0.5, R=\=-1.
_goodWorkex(A,R):- R=:=-1.
_okayWorkex(A,R):-A-R<0.5,A-R>=0, R=\=-1.
_badWorkex(A,R):-not _goodWorkex(A,R),not _okayWorkex(A,R).

_gre(X) :- X >= 170, X =< 340.
_toefl(X) :- X >= 0, X =< 120.
_gpa(X) :- X>=0, X=<10.
_we(X) :- X >= 0.
_b(X) :- X = low.
_b(X) :- X = medium.
_b(X) :- X = high.

_findlist(GreA,ToeflA,GpaA,WeA,BA) :-_safe(X,GreA,ToeflA,GpaA,WeA,BA),
									_university(X),
									_gre(GreA),
									_toefl(ToeflA),
									_gpa(GpaA),
									_we(WeA),
									_b(BA),
									write(X),write(' - safe.').
									
_findlist(GreA,ToeflA,GpaA,WeA,BA) :- _moderate(X,GreA,ToeflA,GpaA,WeA,BA),
									_university(X),
									_gre(GreA),
									_toefl(ToeflA),
									_gpa(GpaA),
									_we(WeA),
									_b(BA),
									write(X),write(' - moderate.').
									
_findlist(GreA,ToeflA,GpaA,WeA,BA) :- _ambitious(X,GreA,ToeflA,GpaA,WeA,BA),
									_university(X),
									_gre(GreA),
									_toefl(ToeflA),
									_gpa(GpaA),
									_we(WeA),
									_b(BA),
									write(X),write(' - ambitious.').

% all conditions are good
_safe(X,GreA,ToeflA,GpaA,WeA,BA) :- _university(X),_requirements(X,GreR,ToeflR,GpaR,WeR,BR),
									_goodGre(GreA,GreR),
									_goodToefl(ToeflA,ToeflR),
									_goodGpa(GpaA,GpaR),
									_goodWorkex(WeA,WeR),
									BA = BR.

% _gre is good and one condition is bad
_safe(X,GreA,ToeflA,GpaA,WeA,BA) :- _university(X),_requirements(X,GreR,ToeflR,GpaR,WeR,BR),
									_goodGre(GreA,GreR),
									_ab(ToeflA,ToeflR,GpaA,GpaR,WeA,WeR),
									not _ab1(ToeflA,ToeflR,GpaA,GpaR,WeA,WeR),
									BA = BR.
							
% 2 conditions can be bad but not more than 2							
_moderate(X,GreA,ToeflA,GpaA,WeA,BA) :- _university(X),_requirements(X,GreR,ToeflR,GpaR,WeR,BR),
									not _ab3(GreA,GreR,ToeflA,ToeflR,GpaA,GpaR,WeA,WeR),
									not _ab4(GreA,GreR,ToeflA,ToeflR,GpaA,GpaR,WeA,WeR),
									_ab2(GreA,GreR,ToeflA,ToeflR,GpaA,GpaR,WeA,WeR), BA = BR.
	
% all conditions are okay	
_moderate(X,GreA,ToeflA,GpaA,WeA,BA) :- _university(X),_requirements(X,GreR,ToeflR,GpaR,WeR,BR),
									_ab6(GreA,GreR,ToeflA,ToeflR,GpaA,GpaR,WeA,WeR),
									BA = BR.

% 3 conditions are okay but not all 4 are okay
_moderate(X,GreA,ToeflA,GpaA,WeA,BA) :- _university(X),_requirements(X,GreR,ToeflR,GpaR,WeR,BR),
									_ab5(GreA,GreR,ToeflA,ToeflR,GpaA,GpaR,WeA,WeR),
									not _ab6(GreA,GreR,ToeflA,ToeflR,GpaA,GpaR,WeA,WeR),
									BA = BR.

% none of the conditions are bad except not all are okay and not _safe
_moderate(X,GreA,ToeflA,GpaA,WeA,BA) :- _university(X),_requirements(X,GreR,ToeflR,GpaR,WeR,BR),
									_ab7(GreA,GreR,ToeflA,ToeflR,GpaA,GpaR,WeA,WeR),
									not _ab5(GreA,GreR,ToeflA,ToeflR,GpaA,GpaR,WeA,WeR),
									not _ab6(GreA,GreR,ToeflA,ToeflR,GpaA,GpaR,WeA,WeR),
									not _safe(X,GreA,ToeflA,GpaA,WeA,BA),
									BA = BR.
% 3 conditions are bad but not all 4									
_ambitious(X,GreA,ToeflA,GpaA,WeA,BA) :- _university(X),_requirements(X,GreR,ToeflR,GpaR,WeR,BR),
									_ab3(GreA,GreR,ToeflA,ToeflR,GpaA,GpaR,WeA,WeR),
									not _ab4(GreA,GreR,ToeflA,ToeflR,GpaA,GpaR,WeA,WeR),
									BA = BR.

% all conditions are bad.
_ambitious(X,GreA,ToeflA,GpaA,WeA,BA) :- _university(X),_requirements(X,GreR,ToeflR,GpaR,WeR,BR),
									_ab4(GreA,GreR,ToeflA,ToeflR,GpaA,GpaR,WeA,WeR),
									BA = BR.
									
% _ab is only one condition is bad and _gre is good.									
_ab(ToeflA,ToeflR,GpaA,GpaR,WeA,WeR):- _badToefl(ToeflA,ToeflR).
_ab(ToeflA,ToeflR,GpaA,GpaR,WeA,WeR):- _badGpa(GpaA,GpaR).
_ab(ToeflA,ToeflR,GpaA,GpaR,WeA,WeR):- _badWorkex(WeA,WeR).

% _ab1 is 2 conditions are bad and _gre is good.
_ab1(ToeflA,ToeflR,GpaA,GpaR,WeA,WeR):- _badToefl(ToeflA,ToeflR),_badGpa(GpaA,GpaR).
_ab1(ToeflA,ToeflR,GpaA,GpaR,WeA,WeR):- _badGpa(GpaA,GpaR),_badWorkex(WeA,WeR).
_ab1(ToeflA,ToeflR,GpaA,GpaR,WeA,WeR):- _badWorkex(WeA,WeR),_badToefl(ToeflA,ToeflR).

% __ab2 is 2 conditions are bad 
_ab2(GreA,GreR,ToeflA,ToeflR,GpaA,GpaR,WeA,WeR):- _badToefl(ToeflA,ToeflR),_badGpa(GpaA,GpaR).
_ab2(GreA,GreR,ToeflA,ToeflR,GpaA,GpaR,WeA,WeR):- _badGpa(GpaA,GpaR),_badWorkex(WeA,WeR).
_ab2(GreA,GreR,ToeflA,ToeflR,GpaA,GpaR,WeA,WeR):- _badWorkex(WeA,WeR),_badToefl(ToeflA,ToeflR).
_ab2(GreA,GreR,ToeflA,ToeflR,GpaA,GpaR,WeA,WeR):- _badToefl(ToeflA,ToeflR),_badGre(GreA,GreR).
_ab2(GreA,GreR,ToeflA,ToeflR,GpaA,GpaR,WeA,WeR):- _badGpa(GpaA,GpaR),_badGre(GreA,GreR).
_ab2(GreA,GreR,ToeflA,ToeflR,GpaA,GpaR,WeA,WeR):- _badWorkex(WeA,WeR),_badGre(GreA,GreR).

% _ab3 is 3 conditions are bad and one condition can be okay or good
_ab3(GreA,GreR,ToeflA,ToeflR,GpaA,GpaR,WeA,WeR):- _badToefl(ToeflA,ToeflR),_badGpa(GpaA,GpaR),_badWorkex(WeA,WeR).
_ab3(GreA,GreR,ToeflA,ToeflR,GpaA,GpaR,WeA,WeR):- _badToefl(ToeflA,ToeflR),_badGpa(GpaA,GpaR),_badGre(GreA,GreR).
_ab3(GreA,GreR,ToeflA,ToeflR,GpaA,GpaR,WeA,WeR):- _badToefl(ToeflA,ToeflR),_badWorkex(WeA,WeR),_badGre(GreA,GreR).
_ab3(GreA,GreR,ToeflA,ToeflR,GpaA,GpaR,WeA,WeR):- _badGpa(GpaA,GpaR),_badWorkex(WeA,WeR),_badGre(GreA,GreR).

% _ab4 is all the conditions are bad
_ab4(GreA,GreR,ToeflA,ToeflR,GpaA,GpaR,WeA,WeR):- _badToefl(ToeflA,ToeflR),_badGpa(GpaA,GpaR),_badWorkex(WeA,WeR),_badGre(GreA,GreR).

% _ab5 is 3 conditions are okay
_ab5(GreA,GreR,ToeflA,ToeflR,GpaA,GpaR,WeA,WeR):- _okayToefl(ToeflA,ToeflR),_okayGpa(GpaA,GpaR),_okayWorkex(WeA,WeR).
_ab5(GreA,GreR,ToeflA,ToeflR,GpaA,GpaR,WeA,WeR):- _okayToefl(ToeflA,ToeflR),_okayGpa(GpaA,GpaR),_okayGre(GreA,GreR).
_ab5(GreA,GreR,ToeflA,ToeflR,GpaA,GpaR,WeA,WeR):- _okayToefl(ToeflA,ToeflR),_okayWorkex(WeA,WeR),_okayGre(GreA,GreR).
_ab5(GreA,GreR,ToeflA,ToeflR,GpaA,GpaR,WeA,WeR):- _okayGpa(GpaA,GpaR),_okayWorkex(WeA,WeR),_okayGre(GreA,GreR).

% _ab6 is all conditions are okay
_ab6(GreA,GreR,ToeflA,ToeflR,GpaA,GpaR,WeA,WeR):- _okayToefl(ToeflA,ToeflR),_okayGpa(GpaA,GpaR),_okayWorkex(WeA,WeR),_okayGre(GreA,GreR).

% _ab7 is none of the conditions are bad
_ab7(GreA,GreR,ToeflA,ToeflR,GpaA,GpaR,WeA,WeR):- not _badToefl(ToeflA,ToeflR),not _badGpa(GpaA,GpaR),not _badWorkex(WeA,WeR),not _badGre(GreA,GreR).


_requirements(asu,317,104,8,-1,low).
_requirements(neu,316,107,8,-1,medium).
_requirements(tamu,323,109,9,2,medium).
_requirements(usc,319,107,9,1,high).
_requirements(utd,314,101,8,-1,low).
_requirements(ncsu,321,107,9,-1,low).
_requirements(uic,317,105,9,-1,high).
_requirements(iit,307,96,8,-1,medium).
_requirements(nyu,322,108,8,1,high).
_requirements(uncc,310,98,8,1.5,low).
_requirements(sjsu,314,104,8,1,high).
_requirements(cmu,330,112,9,1.5,high).
_requirements(uf,319,105,8,-1,medium).
_requirements(ucsd,324,109,9,1.5,high).
_requirements(rit,312,101,8,-1,high).
_requirements(uiuc,325,113,9,1,high).
_requirements(ucla,326,112,9,0.5,high).
_requirements(umass,327,112,9,1,low).
_requirements(njit,306,95,7,0.5,medium).
_requirements(upenn,323,112,9,1,high).
_requirements(mit,330,110,9,3,high).
_requirements(nw,317,110,9,1,medium).
_requirements(bu,312,102,7,-1,high).
_requirements(pace,300,94,7,-1,medium).
_requirements(uta,307,93,8,-1,low).
_requirements(suny,316,99,8,2,medium).
_requirements(gatech,325,97,9,-1,high).
_requirements(vt,323,105,9,1,low).
_requirements(rutgers,321,100,8,-1,low).
_requirements(columbia,326,101,9,1,high).
_requirements(ucb,317,95,9,2,low).
_requirements(ucd,321,108,8,2,high).
_requirements(nyupoly,317,99,8,-1,medium).
_requirements(duke,321,106,7,0.5,medium).
_requirements(wpi,313,100,8,-1,low).

# compute 0 {_findlist(330,105,8,0,medium)}.
%# compute 0 {_findlist(300,100,8,0,medium)}.
%# compute 0 {_findlist(335,100,8,2,medium)}.
%# compute 0 {_findlist(312,105,8,1,high)}.
%# compute 0 {_findlist(325,115,8.5,0,high)}.