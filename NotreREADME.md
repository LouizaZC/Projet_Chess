# Wassim ABOU DAHER

# Kata : Remove nil Checks in MyChessGame

## Objectif

Ce kata vise à améliorer la qualité et la maintenabilité du code en remplaçant les vérifications explicites de `nil` par une solution orientée objet basée sur le polymorphisme. Dans la version originale du jeu d’échecs, une case vide était représentée par `nil`, entraînant de nombreuses vérifications explicites dans le code. Nous avons refactoré ce comportement pour respecter les principes de conception logicielle.

---

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

### 3. API Redessinée
L'API a été repensée pour éviter toute dépendance aux vérifications explicites de `nil`. Désormais, toutes les cases retournent un objet de type `MyPiece`, garantissant une interaction cohérente avec les méthodes du plateau.

---

## Tests

Les tests ont joué un rôle central dans ce refactoring. Étant donné que le remplacement de `nil` par `MyVoidPiece` n'a aucun effet visuel dans le jeu, les tests ont été la seule méthode fiable pour vérifier que les changements fonctionnaient correctement. 

