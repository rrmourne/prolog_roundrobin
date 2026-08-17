:- use_module(library(clpfd)).
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

fix_3(_-C) :-
	C #=< 3.

day_con(D) :-
	global_cardinality(D, C),
	maplist(fix_3, C).

fix_4eq(Di, Dii) :- abs(Di-Dii)#>4.

fix_4b([]).
fix_4b([D|Sn]) :-
	maplist(fix_4eq(D), Sn),
	fix_4b(Sn).

fix_4([]).
fix_4([_-Ds|N]) :-
	fix_4b(Ds),
	fix_4(N).

fix_2b(_,[],0,0).
fix_2b(T,[fixture(A,B,_)|N],Na,Nb) :-
	fix_2b(T,N,Nai,Nbi),
	(T==A->Na#=Nai+1,Nb#=Nbi;
	T==B->Nb#=Nbi+1,Na#=Nai;
	Na#=Nai,Nb#=Nbi).

fix_2([],_).
fix_2([T|N],F) :-
	fix_2b(T, F, A, B),
	A #= 2,
	B #= 2,
	fix_2(N, F).

dass(T, D, [], [T-[D]]).
dass(T, D, [T-Ds|N], [T-[D|Ds]|N]).
dass(T, D, [P|N], [P|Ni]) :-
	P = Ti-_,
	Ti \= T,
	dass(T, D, N, Ni).

fix_gen([], [], [], Ds, Ds).
fix_gen([(X,Y)|Np], [fixture(A,B,D)|Ns], [D|Nd], Ds, Dso) :-
	(A=X, B=Y; A=Y, B=X),
	dass(A, D, Ds, Dsi),
	dass(B, D, Dsi, Dsii),
	D in 1..25,
	fix_gen(Np, Ns, Nd, Dsii, Dso).

schedule(S) :- 
	findall((A,B), pair_gen(A,B), P),
	fix_gen(P, S, D, [], Dso),
	day_con(D),
	findall(T,group(T,_),Ts),
	fix_2(Ts, S),
	fix_4(Dso),
	labelling([ffc, min], D).
