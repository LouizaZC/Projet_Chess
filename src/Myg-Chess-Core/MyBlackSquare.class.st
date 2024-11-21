Class {
	#name : 'MyBlackSquare',
	#superclass : 'MyChessSquare',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'initialization' }
MyBlackSquare >> initialize [

	super initialize.
	color := Color black
]

{ #category : 'rendering' }
MyBlackSquare >> renderBishop: aPiece [

	^ aPiece isWhite 
    ifTrue: ['b']  
    ifFalse: ['v']. 
]

{ #category : 'rendering' }
MyBlackSquare >> renderKing: aPiece [
	^ aPiece isWhite 
		ifTrue: ['k'] 
		ifFalse: ['l'].
]

{ #category : 'rendering' }
MyBlackSquare >> renderKnight: aPiece [

	^ aPiece isWhite
		  ifTrue: [ 'n' ]
		  ifFalse: [ 'm' ]
]

{ #category : 'rendering' }
MyBlackSquare >> renderPawn: aPiece [

	^ aPiece isWhite
		  ifTrue: [ 'p' ]
		  ifFalse: [ 'o' ]
]

{ #category : 'rendering' }
MyBlackSquare >> renderQueen: aPiece [

	^ aPiece isWhite 
	ifTrue: ['q'] 
	ifFalse: ['w'].
]

{ #category : 'rendering' }
MyBlackSquare >> renderRook: aPiece [

^ aPiece isWhite 
	ifTrue: ['r'] 
	ifFalse: ['t'].
]
