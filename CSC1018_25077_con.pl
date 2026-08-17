group(teamaa, groupa).
group(teamab, groupa).
group(teamac, groupa).
group(teamad, groupa).
group(teamae, groupa).

group(teamba, groupb).
group(teambb, groupb).
group(teambc, groupb).
group(teambd, groupb).
group(teambe, groupb).

group(teamca, groupc).
group(teamcb, groupc).
group(teamcc, groupc).
group(teamcd, groupc).
group(teamce, groupc).

group(teamda, groupd).
group(teamdb, groupd).
group(teamdc, groupd).
group(teamdd, groupd).
group(teamde, groupd).

group(teamea, groupe).
group(teameb, groupe).
group(teamec, groupe).
group(teamed, groupe).
group(teamee, groupe).

group(teamfa, groupf).
group(teamfb, groupf).
group(teamfc, groupf).
group(teamfd, groupf).
group(teamfe, groupf).

fixture(A, B, _) :- group(A, C), group(B, C).

pair_gen(A, B) :- fixture(A, B, _), A @< B.

day_con(D) :- between(1, 50, D).

fix_4(_,_,_,[]).
fix_4(A,B,D,[fixture(X,Y,D2)|Sn]) :-
	Di is abs(D-D2),
	(Di>4;(A\=X,A\=Y,B\=X,B\=Y)),
	fix_4(A,B,D,Sn).

fix_3c(_, _, _, [], 0, 0, 0).
fix_3c(A, B, D, [fixture(Ai,Bi,Di)|Sn], Na, Nb, Nd) :-
	fix_3c(A, B, D, Sn, Nai, Nbi, Ndi),
	( A = Ai -> Na is Nai + 1; Na = Nai ),
	( B = Bi -> Nb is Nbi + 1; Nb = Nbi ),
	( D = Di -> Nd is Ndi + 1; Nd = Ndi ).

fix_gen([], S, S).
fix_gen([(X,Y)|N], Sd, S) :-
	(A=X, B=Y; A=Y, B=X),
	day_con(D),
	fix_4(A,B,D,Sd),
	fix_3c(A,B,D,Sd,Nx,Ny,Ni),
	Ni < 3,
	Nx < 2,
	Ny < 2,
	fix_gen(N, [fixture(A,B,D)|Sd], S).

schedule(S) :- findall((A,B), pair_gen(A,B), P), fix_gen(P, [], S).
