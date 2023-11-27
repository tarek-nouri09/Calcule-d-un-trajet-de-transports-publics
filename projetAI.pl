
ligne(2, metro, [
		 [nation, 0],
		 [avron, 1],
		 [alexandre_dumas,2],
		 [philippe_auguste,1],
		 [pere_lachaise,2],
		 [menilmontant,2],
		 [couronnes,1],
		 [belleville,2],
		 [colonel_fabien,1],
		 [jaures,1],
		 [stalingrad,2],
		 [la_chapelle,1],
		 [barbes_rochechouart,3],
		 [anvers,2],
		 [pigalle,1],
		 [blanche,2],
		 [place_clichy,3],
		 [rome,2],
		 [villiers,3],
		 [monceau,2],
		 [courcelles,2],
		 [ternes,3],
		 [charles_de_gaulle_etoile,3],
		 [victor_hugo,2],
		 [porte_dauphine,3]
		 ], [[5,0],2,[1,45]], [[5,15],2,[1,55]]
).

ligne(3, metro, [
		 [pont_levallois_becon,0],
		 [anatole_france,2],
		 [louise_michel,3],
		 [porte_de_champerret,2],
		 [pereire,2],
		 [wagram,2],
		 [malesherbes,3],
		 [villiers,2],
		 [europe,3],
		 [saint_lazare,4],
		 [havre_caumartin,2],
		 [opera,3],
		 [quatre_septembre,3],
		 [bourse,2],
		 [sentier,3],
		 [reaumur_sebastopol,3],
		 [arts_metiers,3],
		 [temple,2],
		 [republique,3],
		 [parmentier,2],
		 [rue_saint_maur,3],
		 [pere_lachaise,4],
		 [gambetta,2],
		 [porte_de_bagnolet,3],
		 [gallieni,3]
		 ], [[5,35],4,[0,20]], [[5,30],4,[0,20]]
).

ligne(bis_3, metro, [
		    [porte_lilas,0],
		    [saint_fargeau,2],
		    [pelleport,1],
		    [gambetta, 2]
		    ], [[6,0],7,[23,45]], [[6,10],7,[23,55]]
).

ligne(5, metro, [
		 [bobigny_pablo_picasso, 0],
		 [bobigny_pantin, 2],
		 [eglise_de_pantin, 3],
		 [hoche,4],
		 [porte_pantin,3],
		 [ourcq,4],
		 [laumiere,3],
		 [jaures,3],
		 [stalingrad,2],
		 [gare_du_nord,3],
		 [gare_de_est,1],
		 [jacques_bonsergent,2],
		 [republique,3],
		 [oberkampf,2],
		 [richard_lenoir,2],
		 [breguet_sabin,2],
		 [bastille,2],
		 [quai_de_la_rapee,3],
		 [gare_austerlitz,2],
		 [saint_marcel,3],
		 [campo_formio,2],
		 [place_italie,3]
		], [[5,24],3,[1,20]], [[5,30],3,[1,0]]
).

ligne(bis_7, metro, [
		    [pre_saint_gervais,0],
		    [place_fetes, 3],
		    [danube, 0],
		    [bolivar, 2],
		    [buttes_chaumont, 2],
		    [botzaris, 2],
		    [jaures, 3],
		    [louis_blanc,2]
		    ], [[5,35],8,[0,0]], [[5,50],8,[23,45]]
).

ligne(11, metro, [
                   [mairie_lilas, 0],
                   [porte_lilas, 3],
                   [telegraphe,1],
                   [place_fetes,1],
QQQQ                   [jourdain, 1],
                   [pyrenees, 1],
                   [belleville, 2],
                   [goncourt, 2],
                   [republique, 3],
                   [arts_metiers, 2],
                   [rambuteau, 1],
                   [hotel_de_ville, 1],
                   [chatelet, 1]
                   ], [[5,15],5,[1,30]], [[5,0],5,[2,0]]
).


addh([Hours, Minutes], AddMinutes, [ResultHours, ResultMinutes]) :-
    ConvMinu is Hours * 60 + Minutes + AddMinutes,
    ResultHours is ConvMinu // 60,
    ResultMinutes is ConvMinu mod 60.

affiche([Hours, Minutes]) :-
    write(Hours), write('H'), write(Minutes).


recherche_arret(Arret, [[Arret|_]|LArret], LArret).
recherche_arret(Arret, [[_|_]|LArret], LArret1):-
	recherche_arret(Arret, LArret, LArret1).

lig(Arret1, Arret2, Ligne):-
	ligne(Ligne,_,LArret,_,_),
	recherche_arret(Arret1, LArret, LArret1),
	recherche_arret(Arret2,LArret1,_).

rcovList1(A1,A2,[H1,H2],L,B5):-
	lig(A1,A2,L),
	ligne(L,_,_,[[X1,X2],Y,_],_),
	B1 is H1*60+H2,
	B2 is X1*60+X2,
       (B1<B2
       -> B5 is B2
       ;
	B3 is abs(B1-B2),
	B4 is (B3//Y)+1,
	B5 is B4*Y+B2).


listR1(A1,A2,H,L,LM):-
	findall([L,B5],(rcovList1(A1,A2,H,L,B5)),LM).

min([], L,MAX,L,MAX ).
min([[L,M]|T],Lact,MAX,L1,MAX1):-
   (M<MAX
   ->  min(T,L,M,L1,MAX1)
   ; min(T,Lact,MAX,L1,MAX1)
   ).

ligtot(A1,A2,L,H):-
    listR1(A1,A2,H,L,LM),
    min(LM,L,10000000,L,_).

calcTout([], 0).
calcTout([[_|X]|T], S):-
    calcTout(T, S1),
    S is S1 + X.


rcovList2(A1, A2, [H1, H2], L, B5):-
    lig(A1, A2, L),
    ligne(L,_,A,[_,Y,[X1,X2]],_),
    B1 is H1*60 + H2,
    B2 is X1*60 + X2,
    calcTout(A, S),
    B10 is S + B2,
    (B1 > B10
        -> B5 is B10
        ;
        B3 is abs(B10 - B1),
        B4 is (B3 // Y) + 1,
        B5 is B10 - B4*Y
    ).


listR2(A1,A2,H,L,LM):-
   findall([L,B5],(rcovList2(A1,A2,H,L,B5)),LM).

max([], L,MAX,L,MAX ).
max([[L,M]|T],Lact,MAX,L1,MAX1):-
   (M>MAX
   ->  max(T,L,M,L1,MAX1)
   ; max(T,Lact,MAX,L1,MAX1)
   ).

ligtard(A1,A2,L,H):-
    listR2(A1,A2,H,L,LM),
    max(LM,L,1,L,_).


















































