# BE-CHTI_final
BE CHTI 
Abir Benazzouz - Rami Karaoud


## Objectif 1 :
**Programmer la DFT en simulation sur un tableau de données imposé**

Le calcul de la DFT est validé avec le jeu de tests, avec lequel nous obtenons bien les résultats attendus.
On met un point d'arrêt ligne 36 du fichier principal.c au niveau du while(1).
On appelle TabSig2 le signal donné par le fichier f1p-45.asm.
On effectue un run dans le debugger. On observe bien dans M2k[1] la valeur 0x3FFFCDE4 donc environ 2^30. Et pour k entre 1 et 63 on a bien M2k < 0x0000000F.
On peut ainsi comparer les valeurs de M2k avec les valeurs attendues contenues en commentaire dans d'autres fichiers de test.

Fenêtre callstack :
![](https://github.com/abirbenazzouz/BE-CHTI_final/blob/master/Screens%20/screen1.PNG)

## Objectif 2:
**Faire tourner la DFT "en réel" et gérer le score des 6 joueurs**

Pour tester: 
On choisit une valeur pour le deuxième argument de la fonction Init_TimingADC_ActiveADC_ff() en se basant sur les informations contenues dans la documentation de la fake lib. 
Pour cet exemple, on chosiit la valeur 0x52, de bit de poids fort 5 et de poids faible 2. Pour cette valeur on attend de voir les chiffres 1 à 6 dans l'ordre dans chacune des cases du tableau score, ce qui est bien observé.
Pour observer, on compile le programme (build) et on lance le debuggeur puis dans la watch window, on affiche toutes les valeurs du tableau score.

Screen Watch 1 : screen2

On peut également tester avec d'autres valeurs : par exemple avec la valeur 0x33 on observe bien les valeurs 1,2,3,4,5,0 dans le tableau score.

Screen Watch 1 : screen 3


## Objectif 3 : 
**Gérer le son**
Pour observer la courbe demandée par l'objectif, il faut compiler le programme, lancer le debugger puis ouvrir une fenêtre logic analyser en mode analog et l'ajuster via le bouton Setup dans une plage allant de 0 à 700 environ.

Allure du son : screen 4



Pour observer le pas entre deux échantillons consécutifs, on place un point d'arrêt ligne (première ligne de la focntion timer_callback). On run une première fois, puis on reset le timer t1 qui s'affiche en bas à droite sur Keil, puis de run une seconde fois. On obtient alors bien 91 microsecondes.

91 micro : screen 5


## Objectif 4 :
**Projet Final**
Pour observer l'objectif final, on ouvre une fenêtre System Analyser, dans laquelle on observe bien que dès que le score d'un joueur est incrémenté, un son se lance également.

Screen System Analyser : screen 6
