Class {
	#name : 'MyPawn',
	#superclass : 'MyPiece',
	#instVars : [
		'hasMoved',
		'board'
	],
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyPawn >> calculateCaptureMoves [
    | captureMoves |
    
    "Sélectionner les cases diagonales en fonction de la couleur"
    captureMoves := { 
        (square + (-1 @ (self isWhite ifTrue: [1] ifFalse: [-1]))).  "Gauche"
        (square + (1 @ (self isWhite ifTrue: [1] ifFalse: [-1]))) }.  "Droite"
    
    "Filtrer les cases où il y a une pièce ennemie"
    ^ captureMoves select: [ :s | s notNil and: [ s hasPiece and: [ s contents color ~= self color ] ] ].
]

{ #category : 'as yet unclassified' }
MyPawn >> doubleForwardSquare [
    ^ self isWhite
        ifTrue: [ (square up) up ]
        ifFalse: [( square down) down ].
]

{ #category : 'as yet unclassified' }
MyPawn >> forwardSquare [
    ^ self isWhite 
        ifTrue: [ square up ]
        ifFalse: [ square down ].
]

{ #category : 'accessing' }
MyPawn >> hasMoved [ 
	^ hasMoved
]

{ #category : 'accessing' }
MyPawn >> hasMoved: aBoolean [
	hasMoved := aBoolean
]

{ #category : 'accessing' }
MyPawn >> id [

	^ 'P'
]

{ #category : 'initialization' }
MyPawn >> initialize [ 
	super initialize.
	hasMoved := false
]

{ #category : 'accessing' }
MyPawn >> isOnStartingPosition [
    ^ self isWhite 
        ifTrue: [ square = MyChessBoard at: 2 ]
        ifFalse: [ square = MyChessBoard at: 7 ].
]

{ #category : 'testing' }
MyPawn >> isPawn [
	
	^ true
]

{ #category : 'rendering' }
MyPawn >> renderPieceOn: aSquare [ 
	
	^ aSquare renderPawn: self
]

{ #category : 'rendering' }
MyPawn >> targetSquaresLegal: includeSpecialMoves [
    | legalMoves singleStepSquare doubleStepSquare captureSquares |

    "Calculer la case pour un pas en avant"
    singleStepSquare := self forwardSquare.

    "Calculer la case pour un double pas en avant"
    doubleStepSquare := self doubleForwardSquare.

    "Initialiser la collection des mouvements légaux"
    legalMoves := OrderedCollection new.

    "Ajout des mouvements de base (un pas en avant)"
    singleStepSquare ifNotNil: [
        singleStepSquare hasPiece ifFalse: [
            legalMoves add: singleStepSquare.

            "Vérifier si le pion peut avancer de deux cases"
            hasMoved ifFalse: [  "Uniquement s'il n'a pas encore bougé"
                doubleStepSquare ifNotNil: [
                    doubleStepSquare hasPiece ifFalse: [
                        legalMoves add: doubleStepSquare ] ] ] ] ].

    "Calcul des captures possibles"
    captureSquares := self calculateCaptureMoves.

    "Retourner les mouvements possibles de captures et de déplacement"
    ^ captureSquares , legalMoves.

]
