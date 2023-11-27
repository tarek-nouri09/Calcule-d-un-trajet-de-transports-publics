README - Prédicats pour l'étude des lignes de transport

Ce projet a pour objectif de développer des outils permettant de manipuler les horaires. Les horaires seront représentés sous forme d'une paire de nombres `[Heures, Minutes]`, où le premier élément représente les heures (de 0 à 23) et le deuxième élément les minutes (de 0 à 59).

Prédicats

1. `addh(X, M, R)`

Ce prédicat est vrai quand R est l'horaire obtenu en ajoutant les minutes M à l'horaire X.

Exemples d'utilisation :

- `addh([13, 34], 30, [14, 4])` est vrai
  - Résultat attendu : `[14, 4]`

- `addh([10, 14], 25, [14, 4])` est faux
  - Résultat attendu : `false`

2. `affiche(H)`

Ce prédicat affiche sur l'écran l'horaire dans un format lisible par l'utilisateur. Par exemple, l'évaluation de `affiche([5,37])` affichera sur l'écran `05h37`.

Exemple d'utilisation :

```prolog
?- affiche([5, 37]).
05h37

pour résoudre le problème de déterminer si une ligne de transport en commun passe par deux arrêts, tout en prenant en compte les choix d'horaires de départs ou d'arrivées.

Prédicats
1. lig
Ce prédicat est vrai lorsque la ligne spécifiée (Ligne) passe de l'arrêt de départ (Arret1) à l'arrêt d'arrivée (Arret2).

Exemple d'utilisation :
?- lig(jaures,stalingrad,L).
L = 2 
?-  lig(jaures,stalingrad,2).
true 

2. ligtot
Ce prédicat est vrai lorsque la ligne spécifiée (Ligne) part le plus tôt possible après un horaire donné (Horaire) parmi toutes les lignes allant de l'arrêt de départ (Arret1) à l'arrêt d'arrivée (Arret2).

Exemple d'utilisation :
?- ligtot(jaures,stalingrad,L,[2,24]).
L=2.

3. ligtard
Ce prédicat est vrai lorsque la ligne spécifiée (Ligne) arrive le plus tard possible avant un horaire donné (Horaire) parmi toutes les lignes allant de l'arrêt de départ (Arret1) à l'arrêt d'arrivée (Arret2).

Exemple d'utilisation :
?- ligtard(jaures,stalingrad,L,[1,36]).
L=5.