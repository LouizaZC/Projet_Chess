Class {
	#name : 'MyWhiteSquare',
	#superclass : 'MyChessSquare',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'initialization' }
MyWhiteSquare >> initialize [

	super initialize.
	color := Color white
]

{ #category : 'rendering' }
MyWhiteSquare >> renderBishop: aPiece [

	^ aPiece isWhite
		  ifTrue: [ 'B' ]
		  ifFalse: [ 'V' ]
]

{ #category : 'rendering' }
MyWhiteSquare >> renderKing: aPiece [

	^ aPiece isWhite
		  ifTrue: [ 'K' ]
		  ifFalse: [ 'L' ]
]

{ #category : 'rendering' }
MyWhiteSquare >> renderKnight: aPiece [

	^ aPiece isWhite
		  ifTrue: [ 'N' ]
		  ifFalse: [ 'M' ]
]

{ #category : 'rendering' }
MyWhiteSquare >> renderPawn: aPiece [

	^ aPiece isWhite
		  ifTrue: [ 'P' ]
		  ifFalse: [ 'O' ]
]

{ #category : 'rendering' }
MyWhiteSquare >> renderQueen: aPiece [

	^ aPiece isWhite
		  ifTrue: [ 'Q' ]
		  ifFalse: [ 'W' ]
]

{ #category : 'rendering' }
MyWhiteSquare >> renderRook: aPiece [

	^ aPiece isWhite
		  ifTrue: [ 'R' ]
		  ifFalse: [ 'T' ]
]
