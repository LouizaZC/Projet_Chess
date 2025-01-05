
# Myg Chess Game :

## Groupe 07 : 

* Louiza ZIANE CHAOUCHE
* Wassim ABOU DAHER
* Meryem EL KOURAICHI 
    

## Prérequis :

Avant de commencer, assurez-vous d'avoir :
* Pharo 12.0 installé.
* Le sujet du TP : [Chess - UnivLille-Meta](https://github.com/UnivLille-Meta/Chess)

## Installation :

Pour importer le projet dans Pharo, procédez comme suit :

* Ouvrez une image Pharo 12.0 .
* Accédez à **Browse > Playground** pour ouvrir un espace de travail.
* Saisissez et exécutez le code suivant :

```smalltalk
Metacello new
    repository: 'github://LouizaZC/Projet_Chess:main';
    baseline: 'MygChess';
    onConflictUseLoaded;
    load.
```

## Exécution du projet:

Après avoir installé le projet, utilisez les instructions ci-dessous pour lancer l'application :

* Ouvrez un Playground **( Browse > Playground )**.
Saisissez et exécutez le code suivant pour initialiser et afficher l'échiquier :

```smalltalk
board := MyChessGame freshGame.
board size: 800@600.
space := BlSpace new.
space root addChild: board.
space pulse.
space resizable: true.
space show.
```
Une fenêtre contenant l'échiquier s'ouvrira, où vous pourrez interagir avec le jeu.

## Emplacement du code et des tests

- **Code source** :
  - Le code du projet se trouve dans le package `Myg-Chess-Core`.
- **Tests** :
  - Les tests unitaires sont situés dans le package `Myg-Chess-Tests`.
  
---

## Katas réalisés :

## Kata Louiza :Fix pawn moves!

Mon kata a pour objectif de mettre en œuvre les règles de déplacement des pions dans un jeu d'échecs, tout en respectant les particularités comme le premier mouvement, les captures diagonales et la prise en passant.


### Partie 1 : Exploration et tests initiaux :

Dans cette première phase du kata, j'ai analysé les classes principales et exploré le comportement des pions afin de corriger plusieurs anomalies liées aux mouvements. Mon objectif était de faire en sorte que les pions respectent les règles fondamentales du jeu d’échecs.

- **MyPawn** : Représente un pion dans le jeu. Elle contient des méthodes essentielles comme renderPieceOn: et targetSquaresLegal:.
- **MyPiece** : Superclasse fournissant des méthodes communes à toutes les pièces, comme square et board.
- **MyChessSquare** : Utile pour vérifier si une case contient une pièce (hasPiece) ou pour accéder à son contenu (contents).


Problèmes observés :

* Les pions capturaient les pièces directement devant eux, ce qui est incorrect.
* Les mouvements des pions n’étaient pas entièrement conformes aux règles, notamment pour le mouvement initial de deux cases ou la prise en passant.
* En exécutant DrTests, j'ai constaté que la couverture de code était de 47,65 %, ce qui est faible. 

J'ai commencé par écrire des tests pour vérifier les déplacements de base des pions.

Avancer d'une case : Le test passe.
Avancer de deux cases depuis la position initiale : Le test échoue.

- Solution :

J'ai utilisé un attribut booléen **firstMove** pour indiquer si le pion est en position de départ.

Dans la méthode **basicMovesLegal**, j'ai ajouté une vérification :

```smalltalk
singleStepSquare := self singleStepSquare.
singleStepSquare ifNotNil: [
    singleStepSquare hasPiece ifFalse: [
        legalMoves add: singleStepSquare.
        self firstMove ifTrue: [
            doubleStepSquare := self doubleStepSquare.
            doubleStepSquare ifNotNil: [
                (singleStepSquare hasPiece not and: [doubleStepSquare hasPiece not]) ifTrue: [
                    legalMoves add: doubleStepSquare
                ]
            ]
        ]
    ]
].
```
Avec cette logique, un pion peut avancer de deux cases uniquement lors de son premier mouvement.


### Partie 2 : Refactorisation et ajout des captures diagonales


Pour améliorer la lisibilité du code, j'ai refactorisé la méthode targetSquaresLegal et séparé les différents calculs des mouvements dans des méthodes spécifiques :

* basicMovesLegal : pour gérer les déplacements de base.
* calculateCaptureMoves : pour les captures diagonales.

Maintenant, les pions capturent correctement en diagonale uniquement.

### Partie 3 : Écriture des tests et implémentation de la prise en passant

Une fois les bases du déplacement des pions en place, je me suis attaqué à la prise en passant. J'ai donc commencé par écrire un test pour vérifier si un pion pouvait capturer un autre pion en passant, après que ce dernier ait effectué un double déplacement. 

Le test commence par créer une partie avec les pions en position initiale : un pion blanc sur e2 et un pion noir sur d7. Je fais d’abord avancer le pion blanc de deux cases, de e2 à e4. Ensuite, je déplace le pion noir de d7 à d5, ce qui simule un mouvement de deux cases. À ce stade, j'attends que le pion blanc soit capable de capturer le pion noir en passant.

```smalltalk
testValidEnPassantCapture 
    | game whitePawn blackPawn initialSquare enPassantSquare |
    game := MyChessGame freshGame.

    whitePawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'e2' ] ].
    blackPawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'd7' ] ].

    game move: whitePawn to: whitePawn square up up.
    game move: whitePawn to: whitePawn square up.
    initialSquare := whitePawn square.

    game move: blackPawn to: blackPawn square down down.
    enPassantSquare := blackPawn square up. 

    self assert: (whitePawn calculateEnPassant includes: enPassantSquare).

    game move: whitePawn to: enPassantSquare.

    self assert: whitePawn square equals: enPassantSquare.
    self deny: initialSquare hasPiece.
    self deny: blackPawn square hasPiece.

```
Mon test échoue au départ, donc il est "rouge". C’est normal, car je n’ai pas encore implémenté la logique pour la prise en passant.


Pour gérer cette logique, j’ai développé la méthode **calculateEnPassant**. Cette méthode a pour rôle principal de déterminer si une prise en passant est possible pour un pion à un moment donné et, le cas échéant, de calculer la case cible pour ce type de capture.

* Étape 1 : Vérification
Si une position en passant a déjà été définie dans l’attribut enPassant (par exemple lors du dernier mouvement d’un pion adverse), elle est immédiatement retournée pour éviter des calculs inutiles.

Étape 2 : Conditions pour la prise en passant
La méthode vérifie que :
* Le dernier coup impliquait un pion adverse qui a avancé de deux cases d’un seul mouvement.
* Ce pion se trouve sur une colonne adjacente au pion actuel.

Étape 3 : Calcul de la case cible
Si les conditions sont réunies, la case cible pour capturer le pion adverse est calculée :
* Si le pion actuel est blanc, la case cible se situe au-dessus du pion adverse.
* Si le pion actuel est noir, elle se situe en dessous du pion adverse.

Étape 4 : Mise à jour de l’attribut enPassant
Une fois la capture possible identifiée, la case cible est ajoutée à une collection de mouvements en passant, et l’attribut enPassant est mis à jour pour refléter cette opportunité.


La méthode **canCaptureEnPassant** complète cette logique en vérifiant si le pion se trouve dans une position spécifique pour permettre une prise en passant. Elle repose sur la position verticale du pion :

Un pion blanc doit être sur la 5e rangée.
Un pion noir doit être sur la 4e rangée.

```smalltalk
canCaptureEnPassant 
	^ self isWhite 
		ifTrue: [ square file = $5 ] 
		ifFalse: [ square file = $4 ] 
``` 
* Enfin, 
la capture en passant s’intègre au système global de déplacements des pions grâce à la classe **MyMove**, que j’ai créée pour centraliser toute la logique de mouvement. Cette classe gère les informations liées à chaque déplacement, comme la case de départ, la case d’arrivée et la pièce impliquée.


### Problèmes rencontrés et solutions :

##### L'implémentation de la règle "en passant" :

* Suivre le dernier mouvement de l'adversaire : fallait-il enregistrer tous les déplacements ou uniquement ceux pertinents pour la règle "en passant" ?
* Identifier les cas cibles spécifiques où la capture est possible.
* Supprimer proprement le pion capturé sans perturber les autres fonctionnalités.

**La solution** :

J'ai introduit une variable d'instance appelée **enPassant** pour mémoriser temporairement la case cible lors d'un double pas adverse. En parallèle, une méthode, **enPcalculateEnPassant**, a été développée pour vérifier si une capture "en passant" est possible et renvoyer la case cible. Enfin, la méthode **moveTo:** a été modifiée pour gérer correctement la capture, y compris la suppression du pion capturé après une capture réussie.


##### Le double pas mal géré :

* Différencier un clic sans déplacement d'un déplacement effectif.
* S'assurer que le double pas ne soit autorisé qu'une seule fois par pion, et uniquement lors de son premier déplacement réel.

**La solution** :

J'ai ajusté la logique dans **moveTo:** en vérifiant si la case de départ et la case d'arrivée étaient identiques. Si oui, le déplacement n'était pas enregistré, et le statut de "premier mouvement" restait inchangé. Cela a permis de préserver l'état initial du pion tant qu'aucun déplacement effectif n'avait été effectué.

#### Tests :

* Tests automatisés :

J'ai développé des tests unitaires dans la classe MyPawnTest pour valider le bon fonctionnement de chaque comportement des pions : déplacement d'une ou deux cases, capture en diagonale, et mouvement "en passant". 

* Tests manuels :

J'ai également réalisé des tests manuels afin de couvrir tous les cas particuliers et de m'assurer que les comportements observés correspondaient aux attentes.


------------------------------------------------------------------------------------------------

## Kata Wassim : Remove nil Checks
## Objectif

Ce kata vise à améliorer la qualité et la maintenabilité du code en remplaçant les vérifications explicites de `nil` par une solution orientée objet basée sur le polymorphisme. Dans la version originale du jeu d’échecs, une case vide était représentée par `nil`, entraînant de nombreuses vérifications explicites dans le code. J'ai refactoré ce comportement pour respecter les principes de conception logicielle.

---

## Organisation des fonctionnalités:
- **Branche `main`** : Elle contient uniquement le développement concernant `MyVoidPiece` + le dev de Louiza. 
- **Branche `Wassim-Remove-nil-checks`** : Cette branche inclut également le développement de `MyOutOfTheBoardCase`. Cependant, comme cette fonctionnalité n'est pas encore complètement stable, elle a été laissée hors de la branche principale pour éviter d'introduire des bugs.

## Solution : Introduction de `MyVoidPiece`

### Qu'est-ce que `MyVoidPiece` ?
`MyVoidPiece` est une classe représentant une "pièce vide". Elle hérite de `MyPiece` et remplace `nil` dans les cases vides. Cette approche utilise le polymorphisme pour garantir que chaque case contient toujours un objet valide, éliminant ainsi la nécessité de vérifier explicitement la présence de `nil`.

---

## Changements Clés

### 1. Création de `MyVoidPiece`
Cette classe implémente des comportements spécifiques aux cases vides :
- **`renderPieceOn:`** : Définit l'apparence visuelle d'une case vide.
- **`targetSquaresLegal:`** : Retourne une liste vide, car une case vide ne peut pas avoir de cibles valides.
- **`isVoidPiece`** : Permet d'identifier une instance de `MyVoidPiece`.

### 2. Refactorisation des Méthodes dans `MyChessSquare`
- **`contents:`** : Remplace `nil` par une instance de `MyVoidPiece`.
- **`emptyContents`** : Réinitialise une case avec `MyVoidPiece`.
- **`hasPiece`** : Vérifie la présence d’une pièce en testant si le contenu est différent de `MyVoidPiece`.
...etc

### 4. Création de `MyOutOfTheBoardCase`
Cette classe gère les cases hors du plateau d'échecs. Elle remplace l'utilisation de `nil` pour ces cases.
- **`up`, `down`, `left`, `right`** : Ces méthodes renvoient une instance de `MyOutOfTheBoardCase`, indiquant que la case est hors du plateau.
- **`hasPiece`** : Retourne `false`, puisqu'une case hors du plateau ne contient pas de pièce.
- **`isOutOfTheBoard`** : Retourne `true`, identifiant la case comme étant hors du plateau.
---

### Difficultés rencontrées
- **Conflits Git** : Après avoir fusionné ma branche `wassim` avec celle de Meriem, j'ai rencontré des conflits majeurs. J'ai résolu cela en créant une nouvelle branche `Wassim-Remove-nil-checks`.
- **Comportement instable des cases hors plateau** : 
Dans le cas de jeu automatique, dans le cas ou la case choisie aléatoirement par le jeu est hors du plateau, la pièce ne change pas de case mais le joueur perd son tour. (le nom de la case OutOfTheBoard s'affiche dans le mesage du mouvement)

## Tests

Les tests ont joué un rôle central dans ce refactoring. Étant donné que le remplacement de `nil` par `MyVoidPiece` n'a aucun effet visuel dans le jeu, les tests ont été la seule méthode fiable pour vérifier que les changements fonctionnaient correctement. 
De même pour la classe MyOutOfTheBoardCase.


------------------------------------------------------------------------------------------------
## Kata Meryem : Refactor piece rendering

Le code ci-dessous présente une complexité excessive dans la logique de rendering des pièces, 
comme on peut le voir dans des méthodes telles que `renderKnight:
```smalltalk
MyChessSquare >> renderKnight: aPiece

    ^ aPiece isWhite
          ifFalse: [ color isBlack
                  ifFalse: [ 'M' ]
                  ifTrue: [ 'm' ] ]
          ifTrue: [
              color isBlack
                  ifFalse: [ 'N' ]
                  ifTrue: [ 'n' ] ]
```


Cette méthode utilise de nombreuses conditions imbriquées pour déterminer l'affichage des pièces en fonction de leur couleur
et de celle de la case. Le code ne respecte pas les normes de codage et de qualité, 
ce qui le rend difficile à comprendre et à maintenir. L'objectif principal est de simplifier cette logique en réduisant le nombre de conditions,
 afin d'améliorer la lisibilité et la maintenabilité du code.

### Exploration et Compréhension du Processus de Rendering des Pièces

Dans cette première phase du kata, j'ai analysé les **classes principales** utilisées dans le contexte du Kata, notamment :
- **`MyChessSquare`**
- **`MyPiece`** et ses sous-classes

### Analyse et Objectifs
Je me suis concentré sur la **logique de rendering des pièces** sur les cases, ainsi que sur son utilité dans le projet. Cette exploration a été essentielle pour :
- Comprendre les **interactions** entre les classes.
- Identifier les **améliorations** potentielles pour rendre le code plus lisible.

### Recherches et Ressources
En approfondissant mes recherches, je suis tombé sur un dépôt GitHub qui explique bien ce processus. Cette ressource m'a aidé à mieux comprendre l'utilité de l'approche adoptée :
- [Open Chess Font - GitHub Repository](https://github.com/joshwalters/open-chess-font/tree/master)

### Solution : Double dispatch (exemple sur la pièce Knight)

Avant la refactorisation, la méthode `renderKnight: aPiece` de la classe `MyChessSquare` était responsable du rendu des chevaliers.
Elle déterminait la couleur de la pièce (blanche ou noire) et, en fonction de la couleur de la case (noire ou autre), elle retournait un caractère (`'M'`, `'m'`, `'N'`, `'n'`) pour afficher la pièce correspondante.

Après les modifications, cette responsabilité a été déplacée dans la classe de la pièce elle-même. La méthode `renderPieceOn: aSquare` a été ajoutée à la classe `MyKnight` et délègue désormais l'affichage de la pièce à la méthode `renderKnight:`.
Cependant, cette dernière n'est plus définie dans la classe `MyChessSquare`, mais dans ses sous-classes spécifiques : `MyBlackSquare` et `MyWhiteSquare`.
Chaque sous-classe gère maintenant le rendu de la pièce en fonction de sa couleur, simplifiant ainsi la logique et respectant les principes de responsabilité unique et d'envoi de messages entre les différentes classes.
#### avant : 

```smalltalk
MyChessSquare >> renderKnight: aPiece

    ^ aPiece isWhite
          ifFalse: [ color isBlack
                  ifFalse: [ 'M' ]
                  ifTrue: [ 'm' ] ]
          ifTrue: [
              color isBlack
                  ifFalse: [ 'N' ]
                  ifTrue: [ 'n' ] ]
```
#### après :
```smalltalk
MyChessSquare >> renderKnight: aPiece [

		self subclassResponsibility
]
MyKnight >> renderPieceOn: aSquare [

	^ aSquare renderKnight: self
] 
MyBlackSquare >> renderKnight: aPiece [

	^ aPiece isWhite
		  ifTrue: [ 'n' ]
		  ifFalse: [ 'm' ]
]
MyWhiteSquare >> renderKnight: aPiece [

	^ aPiece isWhite
		  ifTrue: [ 'N' ]
		  ifFalse: [ 'M' ]
]
```

### Tests 

J'ai développé des tests unitaires dans Toutes les classes pièces qui testent les cas possibles du rendering.la classe MyPawnTest pour valider le bon fonctionnement de chaque comportement des pions : déplacement d'une ou deux cases, capture en diagonale, et mouvement "en passant".

#### Tests effectués sur le rendu des chevaliers comme exemple

Des tests ont été réalisés pour vérifier le bon comportement du rendu des chevaliers et des autres pièces en fonction de la couleur de la pièce et de la couleur de la case. Voici les différents scénarios testés :

- `testRenderBlackKnightBlacksquare`: Vérifie que lorsque le chevalier noir est placé sur une case noire, le caractère `'m'` est retourné.
- `testRenderBlackKnightWhitesquare`: Vérifie que lorsque le chevalier noir est placé sur une case blanche, le caractère `'M'` est retourné.
- `testRenderWhiteKnightWhitesquare`: Vérifie que lorsque le chevalier blanc est placé sur une case blanche, le caractère `'N'` est retourné.
- `testRenderWhiteKnightBlacksquare`: Vérifie que lorsque le chevalier blanc est placé sur une case noire, le caractère `'n'` est retourné.



------------------------------------------------------------------------------------------------
## Mise en commun de nos trois KATA :

Dans le cadre de notre projet Chess, nous avons rencontré des problèmes lors de la mise en commun des trois branches correspondant à nos trois Kata. Ces difficultés provenaient principalement de conflits liés à l’intégration simultanée de plusieurs fonctionnalités.

Pour simplifier le processus et garantir une meilleure organisation, nous avons décidé que chaque membre de l’équipe créerait une branche distincte dédiée à son propre Kata. Cela nous a permis de travailler de manière indépendante tout en facilitant l’intégration progressive des différentes contributions.

* Dans la branche **main**, nous avons intégré et mis en commun les deux Kata suivants :

* **Fix pawn moves!**
* **Remove nil checks**
Cette intégration est désormais fonctionnelle et stable.

Dans la branche **meryem-Refactor-piece-rendering**, nous avons combiné :

* **Fix pawn moves!**
* **Refactor piece rendering**

Cela a permis d’avoir deux branches où différentes combinaisons des Kata sont testées, en fonction des priorités et de l’avancement de chaque partie du projet.

Ce processus nous a permis de progresser de manière structurée tout en réduisant les conflits et en facilitant les tests d'intégration.
