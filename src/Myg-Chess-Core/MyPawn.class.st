Class {
	#name : 'MyPawn',
	#superclass : 'MyPiece',
	#instVars : [
		'firstMove',
		'enPassant'
	],
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyPawn >> basicMovesLegal [ 
    | legalMoves singleStepSquare doubleStepSquare |

    legalMoves := OrderedCollection new.

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

    ^ legalMoves.
]

{ #category : 'as yet unclassified' }
MyPawn >> calculateCaptureMoves [ 
    | captureMoves |

    captureMoves := { 
        (square + (-1 @ (self isWhite ifTrue: [1] ifFalse: [-1]))).  
        (square + (1 @ (self isWhite ifTrue: [1] ifFalse: [-1]))) }.  
    
    ^ captureMoves select: [ :s | s notNil and: [ s hasPiece and: [ s contents color ~= self color ] ] ].

]

{ #category : 'as yet unclassified' }
MyPawn >> calculateEnPassant [ 
    | enPassantMoves lastMove opponentPawnPosition captureTargetPosition |

    "Si une position en passant est déjà définie, la retourner immédiatement"
    enPassant ifNotNil: [ ^ OrderedCollection with: enPassant ].

    "Initialiser une collection vide pour les mouvements en passant possibles"
    enPassantMoves := OrderedCollection new.
    lastMove := square board game lastMove.

    "Vérifier si le dernier mouvement est pertinent pour le en passant"
    lastMove ifNotNil: [
        (lastMove piece isPawn
            and: [ (lastMove fromSquare file asInteger - lastMove toSquare file asInteger) abs = 2 ]) ifTrue: [
            
            "Vérifier si ce pion peut capturer en passant"
            self canCaptureEnPassant ifTrue: [
                opponentPawnPosition := lastMove toSquare.
                
                "Vérifier si la distance horizontale est de 1"
                (self square horizontalDistanceTo: opponentPawnPosition) abs = 1 ifTrue: [
                    captureTargetPosition := self isWhite
                        ifTrue: [ opponentPawnPosition up ]
                        ifFalse: [ opponentPawnPosition down ].
                    
                    "Mettre à jour l'état de en passant et ajouter la position cible"
                    enPassant := captureTargetPosition.
                    enPassantMoves add: captureTargetPosition.
                ].
            ].
        ].
    ].

    ^ enPassantMoves.


]

{ #category : 'testing' }
MyPawn >> canCaptureEnPassant [
	^ self isWhite 
		ifTrue: [ square file = $5 ] 
		ifFalse: [ square file = $4 ] 
]

{ #category : 'as yet unclassified' }
MyPawn >> doubleStepSquare [ 
    ^ square + (0 @ (2 * self forwardDirection)).
]

{ #category : 'accessing' }
MyPawn >> firstMove [
	^ firstMove 
]

{ #category : 'accessing' }
MyPawn >> firstMove: aBoolean [
	firstMove := aBoolean
]

{ #category : 't - rotating' }
MyPawn >> forwardDirection [ 
    ^ self isWhite ifTrue: [ 1 ] ifFalse: [ -1 ].
]

{ #category : 'accessing' }
MyPawn >> id [
	^ 'P'
]

{ #category : 'initialization' }
MyPawn >> initialize [ 
        super initialize.
        firstMove := true.
		 enPassant := nil.
		  

]

{ #category : 'testing' }
MyPawn >> isBlack [
    ^ self color = Color black.

]

{ #category : 'testing' }
MyPawn >> isPawn [
	^ true
]

{ #category : 'testing' }
MyPawn >> isWhite [
    ^ self color = Color white.
]

{ #category : 'path commands' }
MyPawn >> moveTo: aSquare [

	| enPassantTargetSquare doubleStep |
	enPassantTargetSquare := (self calculateEnPassant includes: aSquare)
		                         ifTrue: [
			                         self isWhite
				                         ifTrue: [ aSquare down ]
				                         ifFalse: [ aSquare up ] ].
	enPassantTargetSquare ifNotNil: [
		enPassantTargetSquare emptyContents ].
	doubleStep := self firstMove and: [ aSquare = self doubleStepSquare ].
	aSquare ~= square ifFalse: [ ^ self ].
	super moveTo: aSquare.
	enPassant := doubleStep
		             ifTrue: [ aSquare ]
		             ifFalse: [ nil ].
	firstMove := false
]

{ #category : 'rendering' }
MyPawn >> renderPieceOn: aSquare [ 
	^ aSquare renderPawn: self
]

{ #category : 'as yet unclassified' }
MyPawn >> singleStepSquare [ 
    ^ square + (0 @ self forwardDirection).


]

{ #category : 'rendering' }
MyPawn >> targetSquaresLegal: aBoolean [ 
    | legalMoves captureSquares enPassantSquares|

    legalMoves := OrderedCollection new.

    "Ajout des mouvements de base (un ou deux pas en avant)"
    legalMoves addAll: (self basicMovesLegal).

    "Ajout des captures possibles (diagonales)"
    captureSquares := self calculateCaptureMoves.

    "Ajout des captures en passant"
     enPassantSquares ifNil: [ enPassantSquares := self calculateEnPassant ].

    ^ captureSquares , legalMoves , enPassantSquares.

]
