Class {
	#name : 'MyPawn',
	#superclass : 'MyPiece',
	#instVars : [
		'firstMove'
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
]

{ #category : 'testing' }
MyPawn >> isPawn [
	^ true
]

{ #category : 'path commands' }
MyPawn >> moveTo: aSquare [ 
    (aSquare = square) ifTrue: [
        ^self.  
    ].
    super moveTo: aSquare.
    firstMove ifTrue: [
        firstMove := false.
    ].

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
    | legalMoves captureSquares |

    legalMoves := OrderedCollection new.

    "Ajout des mouvements de base (un ou deux pas en avant)"
    legalMoves addAll: (self basicMovesLegal).

    "Ajout des captures possibles (diagonales)"
    captureSquares := self calculateCaptureMoves.

    ^ captureSquares , legalMoves.

]
