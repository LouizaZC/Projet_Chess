
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

### Kata Louiza :Fix pawn moves!

Mon kata a pour objectif de mettre en œuvre les règles de déplacement des pions dans un jeu d'échecs, tout en respectant les particularités comme le premier mouvement, les captures diagonales et la prise en passant.


#### Partie 1 : Exploration et tests initiaux :

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


#### Partie 2 : Refactorisation et ajout des captures diagonales


Pour améliorer la lisibilité du code, j'ai refactorisé la méthode targetSquaresLegal et séparé les différents calculs des mouvements dans des méthodes spécifiques :

* basicMovesLegal : pour gérer les déplacements de base.
* calculateCaptureMoves : pour les captures diagonales.

Maintenant, les pions capturent correctement en diagonale uniquement.

#### Partie 3 : Écriture des tests et implémentation de la prise en passant

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


#### Problèmes rencontrés et solutions :

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

### Kata Wassim :



------------------------------------------------------------------------------------------------
### Kata Meriem : 




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